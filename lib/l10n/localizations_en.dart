// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_title => 'Sign In';

  @override
  String get login_subtitle => 'Hi there! Nice to see you again.';

  @override
  String get login_email_caption => 'Email';

  @override
  String get login_code_caption => 'Code';

  @override
  String login_code_send(num seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: ' ($seconds)',
      zero: '',
    );
    return 'Send$_temp0';
  }

  @override
  String get login_submit_caption => 'Sign in';
}
