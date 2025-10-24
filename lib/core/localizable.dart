import 'package:flutter/material.dart';

abstract class Localizable {
  String? localized(BuildContext? context);
}

class LocaleString implements Localizable {
  LocaleString(this.raw);
  final String raw;
  @override
  String? localized(BuildContext? context) => raw;
}
