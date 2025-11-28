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

  static const green = Color(0xFF68D784);

  static const logo = Color(0xFFC8122D);
}

// abstract final class MyColors {
//   static const viewBgs = [Colors.green, Colors.red];
//   static Color viewBg(BuildContext context) => viewBgs[Theme.of(context).brightness.index];
//
//   static const black1 = Color(0xFF101010);
//   static const white1 = Color(0xFFFFF7FA);
//   static const grey1 = Color(0xFFF2F2F2);
//   static const grey2 = Color(0xFF4D4D4D);
//   static const grey3 = Color(0xFFA4A4A4);
//   static const whiteTransparent = Color(0x4DFFFFFF); // Figma rgba(255, 255, 255, 0.3)
//   static const blackTransparent = Color(0x4D000000);
//   static const red1 = Color(0xFFE74C3C);
// }
//
// abstract final class MySchemes {
//   static const light = ColorScheme(
//     brightness: Brightness.light,
//     primary: MyColors.black1,
//     onPrimary: MyColors.white1,
//     secondary: Colors.red, // MyColors.black1
//     onSecondary: MyColors.white1,
//     error: Colors.white,
//     onError: Colors.red,
//     surface: Colors.white,
//     onSurface: MyColors.black1,
//   );
//
//   static const dark = ColorScheme(
//     brightness: Brightness.dark,
//     primary: MyColors.white1,
//     onPrimary: MyColors.black1,
//     secondary: Colors.green, // MyColors.white1
//     onSecondary: MyColors.black1,
//     error: Colors.black,
//     onError: MyColors.red1,
//     surface: MyColors.black1,
//     onSurface: Colors.white,
//   );
// }
