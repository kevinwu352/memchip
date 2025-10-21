// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String welcom_msg(Object name) {
    return '你好, $name!';
  }

  @override
  String some_apples(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apples',
      one: '1 apple',
      zero: 'no apples',
    );
    return '你好, $_temp0';
  }

  @override
  String get escap => '你好! {Isn\'t} this\'s a wonderful day?';
}
