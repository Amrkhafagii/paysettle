import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../src/localization/l10n.dart';
import '../../../../src/theme/tokens.dart';
import '../controllers/auth_controller.dart';
import '../state/auth_state.dart';

class ForgotPasswordPage extends HookConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;
    final emailController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      if (next.passwordResetSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.authResetCta)),
        );
        context.pop();
      } else if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(strings.authForgotPassword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.xxl),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(strings.authForgotDescription,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: Spacing.lg),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: strings.authEmailLabel),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.contains('@')
                    ? null
                    : strings.authEmailLabel,
              ),
              const SizedBox(height: Spacing.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: authState.isLoading
                      ? null
                      : () {
                          if (formKey.currentState?.validate() ?? false) {
                            ref
                                .read(authControllerProvider.notifier)
                                .sendPasswordReset(emailController.text.trim());
                          }
                        },
                  child: Text(strings.authResetCta),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
