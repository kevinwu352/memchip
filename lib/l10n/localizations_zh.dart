// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

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
  String get login_email_caption => 'Email';

  @override
  String get login_code_caption => 'Code';

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
  String get home_empty_info => 'No chips yet zh';

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
}
