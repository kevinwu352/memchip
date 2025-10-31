// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get http_error_unknown => 'Unknown Error en';

  @override
  String get http_error_network => 'Network Error en';

  @override
  String get http_error_status => 'Status Error en';

  @override
  String get http_error_decode => 'Decode Error en';

  @override
  String get http_error_operation => 'Operation Failed en';

  @override
  String get http_success => 'Done en';

  @override
  String get login_title => 'Sign In';

  @override
  String get login_subtitle => 'Hi there! Nice to see you again.';

  @override
  String get login_email_title => 'Email';

  @override
  String get login_code_title => 'Code';

  @override
  String login_code_send_btn(num seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: ' ($seconds)',
      zero: '',
    );
    return 'Send$_temp0';
  }

  @override
  String get login_submit_btn => 'Sign in';

  @override
  String get home_section_title => 'My Chips';

  @override
  String get home_empty_info => 'No chips yet';

  @override
  String get home_new_btn => 'New Chip';

  @override
  String get account_nickname_empty => 'Nickname';

  @override
  String get account_phomail_empty => 'N/A';

  @override
  String get about_page_title => 'About Us';

  @override
  String get about_line_license_title => 'Open Source Licenses';

  @override
  String get about_line_term_title => 'Terms of Service';

  @override
  String get about_line_privacy_title => 'Privacy Policy';

  @override
  String get about_logout_btn => 'Log out';

  @override
  String about_version(Object version) {
    return 'Version: $version';
  }

  @override
  String get chip_category_page_title => 'Create Character';

  @override
  String get chip_category_human_info => 'Please add a clear character image.';

  @override
  String get chip_category_human_btn => 'Create Human Character';

  @override
  String get chip_category_pet_info =>
      'Please upload one clear front photo and one side photo of your pet.';

  @override
  String get chip_category_pet_btn => 'Create Pet Character';

  @override
  String get chip_create_image_library => 'Photo library';

  @override
  String get chip_create_image_camera => 'Camera';

  @override
  String get chip_create_gender_male => 'Male';

  @override
  String get chip_create_gender_female => 'Female';
}
