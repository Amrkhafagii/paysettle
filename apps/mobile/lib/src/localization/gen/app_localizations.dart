import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PaySettle'**
  String get appTitle;

  /// No description provided for @journeysTab.
  ///
  /// In en, this message translates to:
  /// **'Journeys'**
  String get journeysTab;

  /// No description provided for @walletTab.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTab;

  /// No description provided for @contactsTab.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsTab;

  /// No description provided for @alertsTab.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alertsTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to PaySettle'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Coordinate journeys, expenses, wallets, insights, and more with a clear design system.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingCTA.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingCTA;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue.'**
  String get authLoginSubtitle;

  /// No description provided for @authSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create new Account'**
  String get authSignupTitle;

  /// No description provided for @authSignupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Already Registered? Log in here.'**
  String get authSignupSubtitle;

  /// No description provided for @authNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get authNameLabel;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authLoginCta.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginCta;

  /// No description provided for @authSignupCta.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get authSignupCta;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authForgotDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password.'**
  String get authForgotDescription;

  /// No description provided for @authResetCta.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get authResetCta;

  /// No description provided for @authAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Already Registered? Log in here.'**
  String get authAlreadyRegistered;

  /// No description provided for @authNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up.'**
  String get authNotRegistered;

  /// No description provided for @authBiometricCta.
  ///
  /// In en, this message translates to:
  /// **'Quick login with biometrics'**
  String get authBiometricCta;

  /// No description provided for @authEnableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric login on this device'**
  String get authEnableBiometrics;

  /// No description provided for @authBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric login not available'**
  String get authBiometricUnavailable;

  /// No description provided for @authBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get authBack;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Unable to complete the request. Please try again.'**
  String get authErrorGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
