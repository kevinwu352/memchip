import 'package:flutter/material.dart';

abstract class Localable {
  String? localized(BuildContext? context);
}

class LocaledStr implements Localable {
  LocaledStr(this.raw);
  final String raw;
  @override
  String? localized(BuildContext? context) => raw;
}
