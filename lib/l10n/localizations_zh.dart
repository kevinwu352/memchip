// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get confirm => '确定';

  @override
  String get cancel => '取消';

  @override
  String get http_error_unknown => 'Unknown Error zh';

  @override
  String get http_error_network => 'Network Error zh';

  @override
  String get http_error_status => 'Status Error zh';

  @override
  String get http_error_decode => 'Decode Error zh';

  @override
  String get http_error_operation => 'Operation Failed zh';

  @override
  String get http_success => 'Done zh';

  @override
  String get login_title => 'Sign In';

  @override
  String get login_subtitle => 'Sign In';

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
  String get home_section_title => 'My Chips zh';

  @override
  String get home_empty_info => 'No chips yet zh';

  @override
  String get home_new_btn => 'New Chip zh';

  @override
  String get account_nickname_empty => '用户昵称';

  @override
  String get account_phomail_empty => '暂无';

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
  String get chip_category_page_title => 'Create Character zh';

  @override
  String get chip_category_human_info =>
      'Please add a clear character image. zh';

  @override
  String get chip_category_human_btn => 'Create Human Character zh';

  @override
  String get chip_category_pet_info =>
      'Please upload one clear front photo and one side photo of your pet. zh';

  @override
  String get chip_category_pet_btn => 'Create Pet Character zh';

  @override
  String get chip_create_page_title => 'Create Image Frame';

  @override
  String get chip_create_image_title => 'Add Image';

  @override
  String get chip_create_image_library => 'Photo library';

  @override
  String get chip_create_image_camera => 'Camera';

  @override
  String get chip_create_image_info_human =>
      'Please add a clear character image.';

  @override
  String get chip_create_image_info_pet =>
      'Please upload one clear front photo and one side photo of your pet.';

  @override
  String get chip_create_basic_title => 'Basic Information';

  @override
  String get chip_create_name_title_human => 'Image Frame Name';

  @override
  String get chip_create_name_ph_human => 'Enter image frame name';

  @override
  String get chip_create_name_title_pet => 'Pet Name';

  @override
  String get chip_create_name_ph_pet => 'Enter pet name';

  @override
  String get chip_create_gender_title => 'Gender';

  @override
  String get chip_create_gender_male_human => 'Male';

  @override
  String get chip_create_gender_female_human => 'Female';

  @override
  String get chip_create_gender_male_pet => 'Boy';

  @override
  String get chip_create_gender_female_pet => 'Girl';

  @override
  String get chip_create_age_title => 'Age Range';

  @override
  String get chip_create_age_ph => 'Select age range';

  @override
  String get chip_create_figure_title => 'Figure Type';

  @override
  String get chip_create_figure_1 => 'Slim';

  @override
  String get chip_create_figure_2 => 'Standard';

  @override
  String get chip_create_figure_3 => 'Fit';

  @override
  String get chip_create_figure_4 => 'Chubby';

  @override
  String get chip_create_species_title => 'Pet Type';

  @override
  String get chip_create_species_cat => 'Cat';

  @override
  String get chip_create_species_dog => 'Dog';

  @override
  String get chip_create_species_rabbit => 'Rabbit';

  @override
  String get chip_create_species_parrot => 'Parrot';

  @override
  String get chip_create_species_hamster => 'Hamster';

  @override
  String get chip_create_species_other => 'Other';

  @override
  String get chip_create_tail_title => 'Tail';

  @override
  String get chip_create_tail_yes => 'With tail';

  @override
  String get chip_create_tail_no => 'No tail';

  @override
  String get chip_create_personality_title => 'Personality';

  @override
  String get chip_create_personality_playful => 'Playful';

  @override
  String get chip_create_personality_quiet => 'Quiet';

  @override
  String get chip_create_personality_foodie => 'Foodie';

  @override
  String get chip_create_personality_timid => 'Timid';

  @override
  String get chip_create_personality_clingy => 'Clingy';

  @override
  String get chip_create_personality_solo => 'Solo';

  @override
  String get chip_create_personality_naughty => 'Naughty';

  @override
  String get chip_create_personality_tame => 'Tame';

  @override
  String get chip_create_create_btn => 'Create';
}
