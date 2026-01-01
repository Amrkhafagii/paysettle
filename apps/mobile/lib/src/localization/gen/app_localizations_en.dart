// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PaySettle';

  @override
  String get journeysTab => 'Journeys';

  @override
  String get walletTab => 'Wallet';

  @override
  String get contactsTab => 'Contacts';

  @override
  String get alertsTab => 'Alerts';

  @override
  String get settingsTab => 'Settings';

  @override
  String get onboardingTitle => 'Welcome to PaySettle';

  @override
  String get onboardingSubtitle =>
      'Coordinate journeys, expenses, wallets, insights, and more with a clear design system.';

  @override
  String get onboardingCTA => 'Get started';

  @override
  String get authLoginTitle => 'Login';

  @override
  String get authLoginSubtitle => 'Sign in to continue.';

  @override
  String get authSignupTitle => 'Create new Account';

  @override
  String get authSignupSubtitle => 'Already Registered? Log in here.';

  @override
  String get authNameLabel => 'Name';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authConfirmPasswordLabel => 'Confirm Password';

  @override
  String get authLoginCta => 'Login';

  @override
  String get authSignupCta => 'Sign up';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authForgotDescription =>
      'Enter your email to reset your password.';

  @override
  String get authResetCta => 'Send reset link';

  @override
  String get authAlreadyRegistered => 'Already Registered? Log in here.';

  @override
  String get authNotRegistered => 'Don\'t have an account? Sign up.';

  @override
  String get authBiometricCta => 'Quick login with biometrics';

  @override
  String get authEnableBiometrics => 'Enable biometric login on this device';

  @override
  String get authBiometricUnavailable => 'Biometric login not available';

  @override
  String get authBack => 'Back';

  @override
  String get authErrorGeneric =>
      'Unable to complete the request. Please try again.';
}
