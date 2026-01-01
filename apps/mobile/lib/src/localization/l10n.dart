import 'package:flutter/widgets.dart';

import 'gen/app_localizations.dart';

export 'gen/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}

class LocalizationConfig {
  const LocalizationConfig._();

  static const Iterable<Locale> supportedLocales =
      AppLocalizations.supportedLocales;
  static const localizationsDelegates = AppLocalizations.localizationsDelegates;
}
