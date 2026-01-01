import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../src/localization/l10n.dart';
import '../../../../src/navigation/routes.dart';
import '../../../../src/theme/tokens.dart';
import '../controllers/auth_controller.dart';
import '../state/auth_state.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      if (next.errorMessage != null && next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.xxl),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => context.canPop()
                      ? context.pop()
                      : context.go(AppRoutes.onboarding),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(strings.authBack),
                ),
                const SizedBox(height: Spacing.sm),
                Text(strings.authSignupTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: Spacing.xs),
                Text(strings.authSignupSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: Spacing.xl),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: strings.authNameLabel),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? strings.authNameLabel
                      : null,
                ),
                const SizedBox(height: Spacing.md),
                TextFormField(
                  controller: emailController,
                  decoration:
                      InputDecoration(labelText: strings.authEmailLabel),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value != null && value.contains('@')
                      ? null
                      : strings.authEmailLabel,
                ),
                const SizedBox(height: Spacing.md),
                TextFormField(
                  controller: passwordController,
                  decoration:
                      InputDecoration(labelText: strings.authPasswordLabel),
                  obscureText: true,
                  validator: (value) => value != null && value.length >= 6
                      ? null
                      : strings.authPasswordLabel,
                ),
                const SizedBox(height: Spacing.md),
                TextFormField(
                  controller: confirmController,
                  decoration: InputDecoration(
                      labelText: strings.authConfirmPasswordLabel),
                  obscureText: true,
                  validator: (value) => value == passwordController.text
                      ? null
                      : strings.authConfirmPasswordLabel,
                ),
                const SizedBox(height: Spacing.xxl),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: authState.isLoading
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              ref.read(authControllerProvider.notifier).signUp(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                  );
                            }
                          },
                    child: Text(strings.authSignupCta),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.authLogin),
                    child: Text(strings.authAlreadyRegistered),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
