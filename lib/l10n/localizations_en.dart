// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get alert_title => 'Attention';

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
  String get login_method_password => 'with Password';

  @override
  String get login_method_otp => 'with OTP';

  @override
  String get login_account_title => 'Account';

  @override
  String get login_account_ph1 => 'Email/Phone/Username';

  @override
  String get login_account_ph2 => 'Email/Phone';

  @override
  String get login_password_title => 'Password';

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
  String get login_register_btn => 'Register';

  @override
  String get register_page_title => 'Register';

  @override
  String get register_account_title => 'Account';

  @override
  String get register_account_ph => 'Email/Phone/Username';

  @override
  String get register_code_title => 'Password';

  @override
  String get register_confirm_title => 'Confirm Password';

  @override
  String get register_submit_btn => 'Register';

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
  String get category_page_title => 'Create Character';

  @override
  String get category_human_info => 'Please add a clear character image.';

  @override
  String get category_human_btn => 'Create Human Character';

  @override
  String get category_pet_info =>
      'Please upload one clear front photo and one side photo of your pet.';

  @override
  String get category_pet_btn => 'Create Pet Character';

  @override
  String get create_page_title => 'Create Image Frame';

  @override
  String get create_image_title => 'Add Image';

  @override
  String get create_image_library => 'Photo library';

  @override
  String get create_image_camera => 'Camera';

  @override
  String get create_image_info_human => 'Please add a clear character image.';

  @override
  String get create_image_info_pet =>
      'Please upload one clear front photo and one side photo of your pet.';

  @override
  String get create_basic_title => 'Basic Information';

  @override
  String get create_name_title_human => 'Image Frame Name';

  @override
  String get create_name_ph_human => 'Enter image frame name';

  @override
  String get create_name_title_pet => 'Pet Name';

  @override
  String get create_name_ph_pet => 'Enter pet name';

  @override
  String get create_gender_title => 'Gender';

  @override
  String get create_gender_male_human => 'Male';

  @override
  String get create_gender_female_human => 'Female';

  @override
  String get create_gender_male_pet => 'Boy';

  @override
  String get create_gender_female_pet => 'Girl';

  @override
  String get create_age_title => 'Age Range';

  @override
  String get create_age_ph => 'Select age range';

  @override
  String get create_age_range1 => 'Children (0-12)';

  @override
  String get create_age_range2 => 'Teenager (13-17)';

  @override
  String get create_age_range3 => 'Youth (18-35)';

  @override
  String get create_age_range4 => 'Middle-Aged (36-59)';

  @override
  String get create_age_range5 => 'Seniors (60+)';

  @override
  String get create_figure_title => 'Figure Type';

  @override
  String get create_figure1 => 'Slim';

  @override
  String get create_figure2 => 'Standard';

  @override
  String get create_figure3 => 'Fit';

  @override
  String get create_figure4 => 'Chubby';

  @override
  String get create_species_title => 'Pet Type';

  @override
  String get create_species_cat => 'Cat';

  @override
  String get create_species_dog => 'Dog';

  @override
  String get create_species_rabbit => 'Rabbit';

  @override
  String get create_species_parrot => 'Parrot';

  @override
  String get create_species_hamster => 'Hamster';

  @override
  String get create_species_other => 'Other';

  @override
  String get create_tail_title => 'Tail';

  @override
  String get create_tail_yes => 'With tail';

  @override
  String get create_tail_no => 'No tail';

  @override
  String get create_personality_title => 'Personality';

  @override
  String get create_personality_playful => 'Playful';

  @override
  String get create_personality_quiet => 'Quiet';

  @override
  String get create_personality_foodie => 'Foodie';

  @override
  String get create_personality_timid => 'Timid';

  @override
  String get create_personality_clingy => 'Clingy';

  @override
  String get create_personality_solo => 'Solo';

  @override
  String get create_personality_naughty => 'Naughty';

  @override
  String get create_personality_tame => 'Tame';

  @override
  String get create_create_btn => 'Create';

  @override
  String get detail_delete_title => 'Warning';

  @override
  String get detail_delete_info => 'Are you sure to delete this item?';
}
