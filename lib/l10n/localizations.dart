import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';
import 'localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/localizations.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @http_error_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error en'**
  String get http_error_unknown;

  /// No description provided for @http_error_network.
  ///
  /// In en, this message translates to:
  /// **'Network Error en'**
  String get http_error_network;

  /// No description provided for @http_error_status.
  ///
  /// In en, this message translates to:
  /// **'Status Error en'**
  String get http_error_status;

  /// No description provided for @http_error_decode.
  ///
  /// In en, this message translates to:
  /// **'Decode Error en'**
  String get http_error_decode;

  /// No description provided for @http_error_operation.
  ///
  /// In en, this message translates to:
  /// **'Operation Failed en'**
  String get http_error_operation;

  /// No description provided for @http_success.
  ///
  /// In en, this message translates to:
  /// **'Done en'**
  String get http_success;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Hi there! Nice to see you again.'**
  String get login_subtitle;

  /// No description provided for @login_email_title.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email_title;

  /// No description provided for @login_code_title.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get login_code_title;

  /// No description provided for @login_code_send_btn.
  ///
  /// In en, this message translates to:
  /// **'Send{seconds, plural, =0{} other{ ({seconds})}}'**
  String login_code_send_btn(num seconds);

  /// No description provided for @login_submit_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_submit_btn;

  /// No description provided for @home_section_title.
  ///
  /// In en, this message translates to:
  /// **'My Chips'**
  String get home_section_title;

  /// No description provided for @home_empty_info.
  ///
  /// In en, this message translates to:
  /// **'No chips yet'**
  String get home_empty_info;

  /// No description provided for @home_new_btn.
  ///
  /// In en, this message translates to:
  /// **'New Chip'**
  String get home_new_btn;

  /// No description provided for @account_nickname_empty.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get account_nickname_empty;

  /// No description provided for @account_phomail_empty.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get account_phomail_empty;

  /// No description provided for @about_page_title.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_page_title;

  /// No description provided for @about_line_license_title.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get about_line_license_title;

  /// No description provided for @about_line_term_title.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get about_line_term_title;

  /// No description provided for @about_line_privacy_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get about_line_privacy_title;

  /// No description provided for @about_logout_btn.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get about_logout_btn;

  /// No description provided for @about_version.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String about_version(Object version);
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
