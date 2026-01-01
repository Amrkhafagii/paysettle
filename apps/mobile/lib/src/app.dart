import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_config.dart';
import 'localization/l10n.dart';
import 'navigation/app_router.dart';
import 'theme/theme_provider.dart';

class PaySettleApp extends ConsumerWidget {
  const PaySettleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(lightThemeProvider);
    final darkTheme = ref.watch(darkThemeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: config.showDebugBanner,
      routerConfig: router,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: LocalizationConfig.localizationsDelegates,
      supportedLocales: LocalizationConfig.supportedLocales.toList(),
    );
  }
}
