import '../entities/settings_overview.dart';

class PreferencesUpdate {
  const PreferencesUpdate({
    this.currency,
    this.theme,
    this.notificationsEnabled,
    this.faceIdEnabled,
  });

  final String? currency;
  final ThemePreference? theme;
  final bool? notificationsEnabled;
  final bool? faceIdEnabled;

  bool get isEmpty =>
      currency == null &&
      theme == null &&
      notificationsEnabled == null &&
      faceIdEnabled == null;
}
