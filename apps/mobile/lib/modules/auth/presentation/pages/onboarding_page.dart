import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../src/localization/l10n.dart';
import '../../../../src/navigation/routes.dart';
import '../../../../src/theme/tokens.dart';
import '../controllers/auth_controller.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key, required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(strings.onboardingTitle,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: Spacing.md),
              Text(strings.onboardingSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  ref
                      .read(authControllerProvider.notifier)
                      .completeOnboarding();
                  onGetStarted();
                },
                child: Text(strings.onboardingCTA),
              ),
              const SizedBox(height: Spacing.sm),
              TextButton(
                onPressed: () => context.go(AppRoutes.authLogin),
                child: Text(strings.authLoginTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
