// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String welcom_msg(Object name) {
    return 'Hello, $name!';
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
    return 'Hello, $_temp0';
  }

  @override
  String get escap => 'Hello! {Isn\'t} this\'s a wonderful day?';
}
