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

  /// No description provided for @alert_title.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get alert_title;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

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

  /// No description provided for @login_method_password.
  ///
  /// In en, this message translates to:
  /// **'with Password'**
  String get login_method_password;

  /// No description provided for @login_method_otp.
  ///
  /// In en, this message translates to:
  /// **'with OTP'**
  String get login_method_otp;

  /// No description provided for @login_account_title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get login_account_title;

  /// No description provided for @login_account_ph1.
  ///
  /// In en, this message translates to:
  /// **'Email/Phone/Username'**
  String get login_account_ph1;

  /// No description provided for @login_account_ph2.
  ///
  /// In en, this message translates to:
  /// **'Email/Phone'**
  String get login_account_ph2;

  /// No description provided for @login_password_title.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password_title;

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

  /// No description provided for @login_register_btn.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_register_btn;

  /// No description provided for @register_page_title.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register_page_title;

  /// No description provided for @register_account_title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get register_account_title;

  /// No description provided for @register_account_ph.
  ///
  /// In en, this message translates to:
  /// **'Email/Phone/Username'**
  String get register_account_ph;

  /// No description provided for @register_code_title.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get register_code_title;

  /// No description provided for @register_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get register_confirm_title;

  /// No description provided for @register_submit_btn.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register_submit_btn;

  /// No description provided for @home_nickname_empty.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get home_nickname_empty;

  /// No description provided for @home_phomail_empty.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get home_phomail_empty;

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

  /// No description provided for @category_page_title.
  ///
  /// In en, this message translates to:
  /// **'Create Character'**
  String get category_page_title;

  /// No description provided for @category_human_info.
  ///
  /// In en, this message translates to:
  /// **'Please add a clear character image.'**
  String get category_human_info;

  /// No description provided for @category_human_btn.
  ///
  /// In en, this message translates to:
  /// **'Create Human Character'**
  String get category_human_btn;

  /// No description provided for @category_pet_info.
  ///
  /// In en, this message translates to:
  /// **'Please upload one clear front photo and one side photo of your pet.'**
  String get category_pet_info;

  /// No description provided for @category_pet_btn.
  ///
  /// In en, this message translates to:
  /// **'Create Pet Character'**
  String get category_pet_btn;

  /// No description provided for @create_page_title.
  ///
  /// In en, this message translates to:
  /// **'Create Image Frame'**
  String get create_page_title;

  /// No description provided for @create_image_title.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get create_image_title;

  /// No description provided for @create_image_library.
  ///
  /// In en, this message translates to:
  /// **'Photo library'**
  String get create_image_library;

  /// No description provided for @create_image_camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get create_image_camera;

  /// No description provided for @create_image_info_human.
  ///
  /// In en, this message translates to:
  /// **'Please add a clear character image.'**
  String get create_image_info_human;

  /// No description provided for @create_image_info_pet.
  ///
  /// In en, this message translates to:
  /// **'Please upload one clear front photo and one side photo of your pet.'**
  String get create_image_info_pet;

  /// No description provided for @create_basic_title.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get create_basic_title;

  /// No description provided for @create_name_title_human.
  ///
  /// In en, this message translates to:
  /// **'Image Frame Name'**
  String get create_name_title_human;

  /// No description provided for @create_name_ph_human.
  ///
  /// In en, this message translates to:
  /// **'Enter image frame name'**
  String get create_name_ph_human;

  /// No description provided for @create_name_title_pet.
  ///
  /// In en, this message translates to:
  /// **'Pet Name'**
  String get create_name_title_pet;

  /// No description provided for @create_name_ph_pet.
  ///
  /// In en, this message translates to:
  /// **'Enter pet name'**
  String get create_name_ph_pet;

  /// No description provided for @create_gender_title.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get create_gender_title;

  /// No description provided for @create_gender_male_human.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get create_gender_male_human;

  /// No description provided for @create_gender_female_human.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get create_gender_female_human;

  /// No description provided for @create_gender_male_pet.
  ///
  /// In en, this message translates to:
  /// **'Boy'**
  String get create_gender_male_pet;

  /// No description provided for @create_gender_female_pet.
  ///
  /// In en, this message translates to:
  /// **'Girl'**
  String get create_gender_female_pet;

  /// No description provided for @create_age_title.
  ///
  /// In en, this message translates to:
  /// **'Age Range'**
  String get create_age_title;

  /// No description provided for @create_age_ph.
  ///
  /// In en, this message translates to:
  /// **'Select age range'**
  String get create_age_ph;

  /// No description provided for @create_age_range1.
  ///
  /// In en, this message translates to:
  /// **'Children (0-12)'**
  String get create_age_range1;

  /// No description provided for @create_age_range2.
  ///
  /// In en, this message translates to:
  /// **'Teenager (13-17)'**
  String get create_age_range2;

  /// No description provided for @create_age_range3.
  ///
  /// In en, this message translates to:
  /// **'Youth (18-35)'**
  String get create_age_range3;

  /// No description provided for @create_age_range4.
  ///
  /// In en, this message translates to:
  /// **'Middle-Aged (36-59)'**
  String get create_age_range4;

  /// No description provided for @create_age_range5.
  ///
  /// In en, this message translates to:
  /// **'Seniors (60+)'**
  String get create_age_range5;

  /// No description provided for @create_figure_title.
  ///
  /// In en, this message translates to:
  /// **'Figure Type'**
  String get create_figure_title;

  /// No description provided for @create_figure1.
  ///
  /// In en, this message translates to:
  /// **'Slim'**
  String get create_figure1;

  /// No description provided for @create_figure2.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get create_figure2;

  /// No description provided for @create_figure3.
  ///
  /// In en, this message translates to:
  /// **'Fit'**
  String get create_figure3;

  /// No description provided for @create_figure4.
  ///
  /// In en, this message translates to:
  /// **'Chubby'**
  String get create_figure4;

  /// No description provided for @create_species_title.
  ///
  /// In en, this message translates to:
  /// **'Pet Type'**
  String get create_species_title;

  /// No description provided for @create_species_cat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get create_species_cat;

  /// No description provided for @create_species_dog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get create_species_dog;

  /// No description provided for @create_species_rabbit.
  ///
  /// In en, this message translates to:
  /// **'Rabbit'**
  String get create_species_rabbit;

  /// No description provided for @create_species_parrot.
  ///
  /// In en, this message translates to:
  /// **'Parrot'**
  String get create_species_parrot;

  /// No description provided for @create_species_hamster.
  ///
  /// In en, this message translates to:
  /// **'Hamster'**
  String get create_species_hamster;

  /// No description provided for @create_species_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get create_species_other;

  /// No description provided for @create_tail_title.
  ///
  /// In en, this message translates to:
  /// **'Tail'**
  String get create_tail_title;

  /// No description provided for @create_tail_yes.
  ///
  /// In en, this message translates to:
  /// **'With tail'**
  String get create_tail_yes;

  /// No description provided for @create_tail_no.
  ///
  /// In en, this message translates to:
  /// **'No tail'**
  String get create_tail_no;

  /// No description provided for @create_personality_title.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get create_personality_title;

  /// No description provided for @create_personality_playful.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get create_personality_playful;

  /// No description provided for @create_personality_quiet.
  ///
  /// In en, this message translates to:
  /// **'Quiet'**
  String get create_personality_quiet;

  /// No description provided for @create_personality_foodie.
  ///
  /// In en, this message translates to:
  /// **'Foodie'**
  String get create_personality_foodie;

  /// No description provided for @create_personality_timid.
  ///
  /// In en, this message translates to:
  /// **'Timid'**
  String get create_personality_timid;

  /// No description provided for @create_personality_clingy.
  ///
  /// In en, this message translates to:
  /// **'Clingy'**
  String get create_personality_clingy;

  /// No description provided for @create_personality_solo.
  ///
  /// In en, this message translates to:
  /// **'Solo'**
  String get create_personality_solo;

  /// No description provided for @create_personality_naughty.
  ///
  /// In en, this message translates to:
  /// **'Naughty'**
  String get create_personality_naughty;

  /// No description provided for @create_personality_tame.
  ///
  /// In en, this message translates to:
  /// **'Tame'**
  String get create_personality_tame;

  /// No description provided for @create_create_btn.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create_create_btn;

  /// No description provided for @detail_delete_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get detail_delete_alert_title;

  /// No description provided for @detail_delete_alert_info.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete this item?'**
  String get detail_delete_alert_info;

  /// No description provided for @detail_activate_info.
  ///
  /// In en, this message translates to:
  /// **'No character yet'**
  String get detail_activate_info;

  /// No description provided for @detail_activate_btn.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get detail_activate_btn;

  /// No description provided for @detail_activate_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Enter serial number:'**
  String get detail_activate_alert_title;

  /// No description provided for @detail_preview_info.
  ///
  /// In en, this message translates to:
  /// **'No preview yet'**
  String get detail_preview_info;

  /// No description provided for @detail_preview_btn.
  ///
  /// In en, this message translates to:
  /// **'Generate Preview'**
  String get detail_preview_btn;

  /// No description provided for @detail_generate_title.
  ///
  /// In en, this message translates to:
  /// **'Select preview image'**
  String get detail_generate_title;

  /// No description provided for @detail_generate_info.
  ///
  /// In en, this message translates to:
  /// **'Please select one image from below to create a your chips.'**
  String get detail_generate_info;

  /// No description provided for @detail_generate_btn.
  ///
  /// In en, this message translates to:
  /// **'Generate Chips'**
  String get detail_generate_btn;
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
