# Navigation Flows & App Architecture Shell

The following flows finalize the navigation structure promised for Phase 0. They assume `go_router` with nested routes inside a shell that carries the bottom navigation bar. Abbreviations: `BN` = Bottom Navigation, `MODAL` = modal sheet, `STACK[x]` = nested stack depth.

## 1. App Shell & Routing

```
/ (Splash) → /onboarding → /auth (signup/login/forgot) → /app (shell)
/app => ProviderScope + ErrorMiddleware
/app routes:
  • /wallet (BN index 0)
  • /journeys (BN index 1)
  • /contacts (BN index 2)
  • /alerts (BN index 3)
  • /settings (BN index 4)
```

- Each BN item keeps its own navigation stack via `StatefulShellRoute` with independent `Navigator` keys for Wallet, Journeys, Contacts, Notifications, and Settings.
- Global actions (e.g., floating “+ Journey/Expense”) push onto the focused stack through shell-level `GoRouter.of(context).push` helpers.

## 2. Authentication Journey

1. Splash → checks Supabase session + biometrics setting.  
2. If unauthenticated: `OnboardingCarousel` → `CreateAccount` (Name, Email, Password) → `VerifyEmail` overlay when Supabase returns OTP (optional).  
3. Existing user taps `Log in here` to reach Login screen (Name/Email + Password).  
4. Forgot password pushes `/auth/forgot`.  
5. Successful auth stores session via Supabase client + local secure storage, then `go('/app?initialTab=wallet')`.

## 3. Wallet Stack

- `WalletHome` (Graph/time filters).  CTA rows navigate to:  
  - `CollectFromDetail` (list of debtors).  
  - `PayToDetail` (list of creditors).  
  - `SettlementLog` (chronological history).  
- `PaymentMethods` accessible via FAB or Settings/Linked Accounts.  
- `SettleNow` modal triggered from CTA; prompts amount & payment method.

## 4. Journeys Stack

- `JourneysHome` displays tabs (Active/Past/Calendar), quick cards for “New Journeys.”  
- Selecting a journey pushes `JourneyDetail` with segmented control (Spending/Settlement).  
  - Spending tab: table view with Add/Edit/Inspect/Report/Dispute actions (buttons). Each action pushes/presents:  
    - `ExpenseEditor` (modal).  
    - `ExpenseInspector` (STACK+1).  
    - `ReportExport` (sheet hooking Supabase storage).  
    - `DisputeFlow` (wizard).  
  - Settlement tab: donut + bar charts + `SettleAllPayments` CTA → `SettlementWizard` (multistep).  
- Global FAB “+ Journey / + Expense” uses context-specific actions.

## 5. Contacts Stack

- `ContactsList` (search + sort).  
- Tapping contact pushes `ContactProfile` with action chips (message, add to journey, request payment).  
- `AddContact` accessible via FAB or Settings.

## 6. Alerts / Notifications Stack

- `NotificationsHome` groups cards into “New” and “Earlier.”  
- Each card encapsulates deeplink metadata (`targetRoute`, `payloadId`). Selecting a card pops to the shell and pushes into the relevant stack (Wallet/Journey/etc).  
- Filter/overflow menu to mark all as read, manage subscriptions.

## 7. Settings Stack

- `SettingsHome` houses sections (Account, Preferences, Security, Integrations).  
- Search field filters the list but also accepts direct nav commands (type “currency” to open Currency screen).  
- Each row pushes its detail page: Personal Information, Linked Accounts, Subscription Plan, Currency, Dark Mode toggle, Notifications, Change Password, Face ID, Export Data, Connect Accounting.  
- App version row opens About modal.

## 8. Cross-Cutting Navigation Rules

- Use `Navigator.pop()` for in-stack Back arrow, not shell-level pops, to preserve each stack’s history when switching tabs.  
- Provide `RouteObserver`-backed analytics hooks from `go_router` to Supabase analytics tables.  
- Every CTA from the screenshots has an equivalent route + query parameters defined here to prevent orphan UI states later.
