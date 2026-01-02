import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/pages/forgot_password_page.dart';
import '../../modules/auth/presentation/pages/login_page.dart';
import '../../modules/auth/presentation/pages/onboarding_page.dart';
import '../../modules/auth/presentation/pages/signup_page.dart';
import '../../modules/budgeting/presentation/pages/budgeting_page.dart';
import '../../modules/contacts/presentation/pages/contacts_page.dart';
import '../../modules/insights/presentation/pages/insights_page.dart';
import '../../modules/journeys/presentation/pages/journeys_page.dart';
import '../../modules/notifications/presentation/pages/notifications_page.dart';
import '../../modules/settings/presentation/pages/profile_page.dart';
import '../../modules/settings/presentation/pages/settings_page.dart';
import '../../modules/wallet/presentation/pages/wallet_page.dart';
import '../config/app_config.dart';
import '../navigation/app_shell.dart';
import '../navigation/routes.dart';
import '../../modules/auth/presentation/controllers/auth_controller.dart';
import '../../modules/auth/presentation/state/auth_state.dart';
import '../../modules/journeys/presentation/pages/journey_detail_page.dart';
import '../../modules/journeys/presentation/pages/journey_editor_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final config = ref.watch(appConfigProvider);
  final authController = ref.watch(authControllerProvider.notifier);
  final authState = ref.watch(authControllerProvider);
  final refreshListenable =
      _RouterRefreshStream(authController.stream.asBroadcastStream());
  ref.onDispose(refreshListenable.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: config.initialRoute,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isAuthRoute = location.startsWith('/auth');
      final isOnboardingRoute = location == AppRoutes.onboarding;
      final isPublicRoute = isAuthRoute || isOnboardingRoute;

      if (authState.status == AuthStatus.initializing) {
        return null;
      }

      if (!authState.hasCompletedOnboarding && !isOnboardingRoute) {
        return AppRoutes.onboarding;
      }

      if (authState.hasCompletedOnboarding && isOnboardingRoute) {
        return authState.status == AuthStatus.authenticated
            ? AppRoutes.wallet
            : AppRoutes.authLogin;
      }

      final isAuthenticated = authState.status == AuthStatus.authenticated;

      if (!isAuthenticated && !isPublicRoute) {
        return AppRoutes.authLogin;
      }

      if (isAuthenticated && (isAuthRoute || isOnboardingRoute)) {
        return AppRoutes.wallet;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => OnboardingPage(
          onGetStarted: () => context.go(AppRoutes.authSignup),
        ),
      ),
      GoRoute(
        path: AppRoutes.authLogin,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.authSignup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.authForgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wallet,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: WalletPage()),
                routes: [
                  GoRoute(
                    path: 'budgeting',
                    builder: (context, state) => const BudgetingPage(),
                  ),
                  GoRoute(
                    path: 'insights',
                    builder: (context, state) => const InsightsPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.journeys,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: JourneysPage()),
                routes: [
                  GoRoute(
                    path: ':journeyId',
                    builder: (context, state) {
                      final rawName =
                          state.pathParameters['journeyId'] ?? 'Journey';
                      return JourneyDetailPage(
                        journeyName: Uri.decodeComponent(rawName),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const JourneyEditorPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.contacts,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ContactsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.alerts,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: NotificationsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SettingsPage()),
                routes: [
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => const ProfilePage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
