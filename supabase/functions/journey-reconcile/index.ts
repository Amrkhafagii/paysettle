import { serve } from "https://deno.land/std@0.203.0/http/server.ts";
import { createClient } from "https://esm.sh/v135/@supabase/supabase-js@2.42.0?target=deno";

type JourneyTotals = {
  totalSpent?: number | string;
  categories?: Array<{ categoryId: string; label: string; amount: number }>;
  participants?: Array<{
    profileId: string;
    paid: number;
    owed: number;
    net: number;
    settlementStatus: string;
  }>;
};

type ExpenseRow = {
  expense_id: string;
  journey_id: string;
  occurred_on: string;
  payer_id: string;
  category_id: string | null;
  amount: number;
  status: string;
  split_type: string;
  notes: string | null;
  shares: Array<{ participantId: string; amount: number; percent: number | null; isPayer: boolean }>;
};

const supabaseUrl =
  Deno.env.get("SUPABASE_URL") ?? Deno.env.get("SERVICE_SUPABASE_URL");
const serviceKey =
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ??
  Deno.env.get("SERVICE_SUPABASE_ROLE_KEY");
const reportsBucket = Deno.env.get("JOURNEY_REPORTS_BUCKET") ?? "journey-reports";

if (!supabaseUrl || !serviceKey) {
  throw new Error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY env variables.");
}

serve(async (req) => {
  if (req.method !== "POST") {
    return jsonResponse({ error: "Method not allowed" }, 405);
  }

  const authHeader = req.headers.get("Authorization");
  if (!authHeader) {
    return jsonResponse({ error: "Missing Authorization header" }, 401);
  }

  const token = authHeader.replace("Bearer", "").trim();
  if (!token) {
    return jsonResponse({ error: "Invalid bearer token" }, 401);
  }

  let body: { journeyId?: string; exportType?: "csv" | "pdf" } = {};
  try {
    body = await req.json();
  } catch (_) {
    return jsonResponse({ error: "Body must be valid JSON" }, 400);
  }

  const { journeyId, exportType } = body;
  if (!journeyId) {
    return jsonResponse({ error: "journeyId is required" }, 400);
  }

  const supabase = createClient(supabaseUrl, serviceKey, {
    global: {
      headers: { Authorization: `Bearer ${token}` },
    },
    auth: { persistSession: false },
  });

  const { data: userData, error: userError } = await supabase.auth.getUser(token);
  if (userError || !userData?.user) {
    return jsonResponse({ error: "Unable to resolve user" }, 401);
  }
  const userId = userData.user.id;

  const { data: membership, error: membershipError } = await supabase
    .from("journey_participants")
    .select("journey_id")
    .eq("journey_id", journeyId)
    .eq("profile_id", userId)
    .eq("state", "confirmed")
    .maybeSingle();

  if (membershipError) {
    return jsonResponse({ error: membershipError.message }, 400);
  }

  if (!membership) {
    return jsonResponse({ error: "Forbidden" }, 403);
  }

  const { data: journey, error: journeyError } = await supabase
    .from("journeys")
    .select("id,title,status,start_on,end_on,currency,totals")
    .eq("id", journeyId)
    .single();

  if (journeyError) {
    return jsonResponse({ error: journeyError.message }, 404);
  }

  const { data: expenses = [], error: expenseError } = await supabase.rpc<ExpenseRow>(
    "journey_expense_sheet",
    { p_journey_id: journeyId, p_limit: 500, p_offset: 0 },
  );

  if (expenseError) {
    return jsonResponse({ error: expenseError.message }, 400);
  }
  const normalizedExpenses: ExpenseRow[] = (expenses ?? []).map((row) => ({
    ...row,
    shares: Array.isArray(row.shares) ? row.shares : [],
  }));

  const { data: settlementActions = [], error: settlementError } = await supabase
    .from("settlement_actions")
    .select("id,action_type,status,amount,currency,initiator_id,target_id,created_at")
    .eq("journey_id", journeyId)
    .order("created_at", { ascending: false })
    .limit(25);

  if (settlementError) {
    return jsonResponse({ error: settlementError.message }, 400);
  }

  const totals = (journey.totals ?? {}) as JourneyTotals;
  const summary = buildSummary(totals, normalizedExpenses);

  let exportResult: { bucket: string; path: string } | null = null;
  if (exportType) {
    exportResult = await persistExport(supabase, {
      journeyId,
      exportType,
      journeyTitle: journey.title,
      expenses: normalizedExpenses,
    });
  }

  return jsonResponse({
    journey,
    summary,
    expenses: normalizedExpenses,
    settlementActions,
    export: exportResult,
  });
});

function buildSummary(totals: JourneyTotals, expenses: ExpenseRow[]) {
  const totalSpent = Number(totals.totalSpent ?? 0);
  const categories = (totals.categories ?? []).map((cat) => ({
    categoryId: cat.categoryId,
    label: cat.label,
    amount: Number(cat.amount ?? 0),
  }));

  const participants = (totals.participants ?? []).map((participant) => ({
    profileId: participant.profileId,
    paid: Number(participant.paid ?? 0),
    owed: Number(participant.owed ?? 0),
    net: Number(participant.net ?? 0),
    settlementStatus: participant.settlementStatus,
  }));

  const lastUpdatedExpense = expenses[0];

  return {
    totalSpent,
    categories,
    participants,
    lastActivityAt: lastUpdatedExpense?.occurred_on ?? null,
  };
}

async function persistExport(
  supabase: ReturnType<typeof createClient>,
  params: {
    journeyId: string;
    exportType: "csv" | "pdf";
    journeyTitle: string;
    expenses: ExpenseRow[];
  },
): Promise<{ bucket: string; path: string } | null> {
  const { journeyId, exportType, journeyTitle, expenses } = params;
  const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
  const safeTitle = journeyTitle.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");
  const extension = exportType === "pdf" ? "pdf" : "csv";
  const path = `${journeyId}/reports/${timestamp}-${safeTitle || "journey"}.${extension}`;

  let payload: Uint8Array;
  let contentType = "text/csv";
  if (exportType === "pdf") {
    // Placeholder PDF payload until PDF templates land in Phase 5 integrations.
    const pdfStub = JSON.stringify({
      journeyId,
      generatedAt: timestamp,
      note: "PDF generation placeholder. Replace with real template renderer.",
    });
    payload = new TextEncoder().encode(pdfStub);
    contentType = "application/json";
  } else {
    const csv = buildCsv(expenses);
    payload = new TextEncoder().encode(csv);
  }

  const { error } = await supabase.storage
    .from(reportsBucket)
    .upload(path, payload, { contentType, upsert: true });

  if (error) {
    console.error("Failed to upload report", error.message);
    return null;
  }

  return { bucket: reportsBucket, path };
}

function buildCsv(rows: ExpenseRow[]): string {
  const header = ["Date", "Amount", "CategoryId", "PayerId", "SplitType", "Notes", "Shares"].join(",");
  const data = rows.map((row) => {
    const shares = (row.shares ?? [])
      .map((share) => `${share.participantId}:${share.amount}`)
      .join("|");
    return [
      row.occurred_on,
      row.amount,
      row.category_id ?? "",
      row.payer_id,
      row.split_type,
      row.notes?.replace(/\n/g, " ") ?? "",
      shares,
    ].join(",");
  });
  return [header, ...data].join("\n");
}

function jsonResponse(payload: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(payload), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}
