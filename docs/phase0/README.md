# Phase 0 – Foundations

This document captures the locked scope, UX journeys, and shared design language for **PaySettle** so designers, engineers, and stakeholders can rally around a single source of truth before any feature implementation begins. It distills the requirements discussed with the provided UI references and ties them to actionable deliverables for later phases.

## 1. Product Scope (Locked)

| Pillar | Goal | Core Screens / Modules |
| --- | --- | --- |
| Journeys | Coordinate shared expenses per trip/event with dispute + reporting workflows. | My Journeys dashboard (Active/Past/Calendar), Journey Details (Spending & Settlement tabs), Add/Edit Expense, Inspect/Dispute, Export PDF/CSV |
| Wallet | Provide single-source tally of what a user owes or is owed, plus settlement CTAs. | Wallet Overview, Balances by timeframe, Collect vs Pay lists, Settlement log, Graph analytics |
| Budgeting | Plan and monitor recurring budgets at category + aggregate level. | Budget overview, Category breakdown cards, Add/Edit budget flow, Alerts |
| Insights | Highlight spend trends, category splits, and recommended actions. | Insights & Reports (time-range filter, trend line, donut/pie, bar charts, recent insights) |
| Settings & Profile | Manage identity, payment methods, subscriptions, preferences, security. | Profile summary, Payment methods, Pending orders, Settings hub (searchable) |
| Notifications | Streamline alerts for payments, budgets, reminders across devices. | Notification center (New/Earlier grouping, message types), real-time pushes |
| Contacts | Network of participants to tie into journeys/settlements. | Contacts list w/ sort & search, detail actions |

## 2. UX Principles

1. **Light, confident greens** convey financial wellness; imagery stays friendly with rounded shapes.  
2. **Card-based summaries** precede detail tables to keep data-dense screens approachable.  
3. **Nudges first, actions second**: CTA order is view → analyze → resolve (e.g., Inspect --> Dispute).  
4. **Bottom navigation** anchors the core app sections with nested stacks for each area.  
5. **Accessibility**: minimum 4.5:1 contrast, large tap targets (>48px), biometric-first quick actions.

## 3. UX Journeys Overview

See [`navigation_flows.md`](navigation_flows.md) for full entrypoints, but key obligations include:

- **Onboarding & Auth**: Welcome → Create Account → Verification → Profile primer → bottom-nav shell.  
- **Journey Lifecycle**: Dashboard → Journey Detail (Spending) → Add/Edit Expense → Inspect → Settlement tab → Settle actions → Export/report/dispute.  
- **Wallet Cycle**: Wallet tab → timeframe filter (Day/Week/Month/Year) → Collect vs Pay sections → Settlement log → Payment method actions.
- **Budgeting Cycle**: Alerts from Notifications → Budget detail → Add budget → Receive push when thresholds pass → Reconcile via Insights.
- **Notifications Cycle**: CTA deep links to Wallet, Journeys, Alerts, or Settings per card metadata.

## 4. Design System Tokens

Tokens are captured in [`../../design/tokens.json`](../../design/tokens.json). They cover:

- **Color ramps** for brand primary greens, neutrals, semantic states, gradients (Spending vs Settlement).  
- **Typography** aligned with Material 3 display/headline/title/label scales plus custom weights from Google Fonts (e.g., Work Sans / Manrope).  
- **Spacing & radii** for the soft-card look (24px corner radius baseline).  
- **Elevation** guidelines for soft-drop cards from screenshots.  
- **Component tokens** for buttons, chips, tables, graph backgrounds.

## 5. Acceptance Criteria for Phase 0

- ✅ Feature set, journeys, and navigation flows have been recorded in living docs.  
- ✅ Design tokens enumerated for Material 3 theme integration + Riverpod/Bloc friendly constants.  
- ✅ Repo skeleton (see Phase 1 entry doc) prepared with `melos`, flavors, and linting (tracked separately once scaffolding lands).

Maintainers should treat this document as immutable unless Phase 0 scope formally changes. All later phases MUST trace requirements back here before being marked complete.
