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
  String get chip_create_image_library => 'Photo library zh';

  @override
  String get chip_create_image_camera => 'Camera zh';

  @override
  String get chip_create_gender_male => '男';

  @override
  String get chip_create_gender_female => '女';

  @override
  String get chip_create_figure_1 => 'Slim zh';

  @override
  String get chip_create_figure_2 => 'Standard zh';

  @override
  String get chip_create_figure_3 => 'Fit zh';

  @override
  String get chip_create_figure_4 => 'Chubby zh';

  @override
  String get chip_create_create_btn => 'Create zh';
}
