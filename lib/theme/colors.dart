import 'package:flutter/material.dart';

// [dark, light]

// MyColors.xxxs          => color list
// MyColors.xxx(context)  => color for current theme
// MyColors.xxx           => single color

abstract final class MyColors {
  static const white100 = Color(0xFFFFFFFF);
  static const white80 = Color(0xFFFFFFFF);

  static const gray100 = Color(0xFFFAFAFA);
  static const gray200 = Color(0xFFF5F5F5);
  static const gray300 = Color(0xFFE5E5E5);
  static const gray400 = Color(0xFFD4D4D4);
  static const gray500 = Color(0xFFA3A3A3);
  static const gray600 = Color(0xFF525252);
  static const gray700 = Color(0xFF262626);
  static const gray800 = Color(0xFF171717);

  static const violet00 = Color(0xFFEEF0FF);
  static const violet50 = Color(0xFFC7CDFF);
  static const violet100 = Color(0xFFAEB6F7);
  static const violet200 = Color(0xFFA6ACFA);
  static const violet250 = Color(0xFFA6ACFA);
  static const violet300 = Color(0xFF7E80D7);

  static const orange100 = Color(0xFFFFE9DA);
  static const orange200 = Color(0xFFFFC59D);
  static const orange300 = Color(0xFFFBB383);
  static const orange400 = Color(0xFFFEA263);
  static const orange500 = Color(0xFFFF8D28);

  static const logo = Color(0xFFC8122D);
}
