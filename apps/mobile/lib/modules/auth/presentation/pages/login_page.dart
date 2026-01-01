import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../src/localization/l10n.dart';
import '../../../../src/navigation/routes.dart';
import '../../../../src/theme/tokens.dart';
import '../controllers/auth_controller.dart';
import '../state/auth_state.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final authState = ref.watch(authControllerProvider);
    final enableBiometrics = useState(authState.biometricsEnabled);

    useEffect(() {
      enableBiometrics.value = authState.biometricsEnabled;
      return null;
    }, [authState.biometricsEnabled]);

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
                Text(strings.authLoginTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: Spacing.xs),
                Text(strings.authLoginSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: Spacing.xl),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.authForgotPassword),
                    child: Text(strings.authForgotPassword),
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(strings.authEnableBiometrics),
                  subtitle: authState.canUseBiometrics
                      ? null
                      : Text(strings.authBiometricUnavailable),
                  value: enableBiometrics.value,
                  onChanged: authState.isLoading || !authState.canUseBiometrics
                      ? null
                      : (value) {
                          enableBiometrics.value = value;
                        },
                ),
                const SizedBox(height: Spacing.xxl),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: authState.isLoading
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              ref.read(authControllerProvider.notifier).signIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                    enableBiometrics: enableBiometrics.value,
                                  );
                            }
                          },
                    child: Text(strings.authLoginCta),
                  ),
                ),
                if (authState.biometricsEnabled &&
                    authState.canUseBiometrics) ...[
                  const SizedBox(height: Spacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: authState.isLoading
                          ? null
                          : () => ref
                              .read(authControllerProvider.notifier)
                              .authenticateWithBiometrics(),
                      icon: const Icon(Icons.fingerprint_rounded),
                      label: Text(strings.authBiometricCta),
                    ),
                  ),
                ],
                const SizedBox(height: Spacing.md),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.authSignup),
                    child: Text(strings.authNotRegistered),
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
