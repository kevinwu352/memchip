import 'package:flutter/material.dart';

abstract final class MyStyles {
  static const String fontFamily = 'Bitcount Single';

  static const title1 = TextStyle(fontFamily: fontFamily, fontSize: 60, fontWeight: FontWeight.w800);
  static const title2 = TextStyle(fontFamily: fontFamily, fontSize: 48, fontWeight: FontWeight.w800);
  static const title3 = TextStyle(fontFamily: fontFamily, fontSize: 34, fontWeight: FontWeight.w900);

  static const headline = TextStyle(fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w800);
  static const subheadline = TextStyle(fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w800);

  static const body = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w400);
  static const bodyBold = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w800);
  static const smallBody = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400);
  static const smallBodyBold = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w800);

  static const caption = TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w700);

  static const buttonLarge = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w700);
  static const buttonMedium = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w800);
  static const buttonSmall = TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w800);
}
