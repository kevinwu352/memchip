import 'package:flutter/material.dart';

// [dark, light]

// MyColors.xxxs          => color list
// MyColors.xxx(context)  => color for current theme
// MyColors.xxx           => single color

abstract final class MyColors {
  static const viewBgs = [Colors.green, Colors.red];
  static Color viewBg(BuildContext context) => viewBgs[Theme.of(context).brightness.index];

  static const black1 = Color(0xFF101010);
  static const white1 = Color(0xFFFFF7FA);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xFF4D4D4D);
  static const grey3 = Color(0xFFA4A4A4);
  static const whiteTransparent = Color(0x4DFFFFFF); // Figma rgba(255, 255, 255, 0.3)
  static const blackTransparent = Color(0x4D000000);
  static const red1 = Color(0xFFE74C3C);
}

abstract final class MySchemes {
  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: MyColors.black1,
    onPrimary: MyColors.white1,
    secondary: Colors.red, // MyColors.black1
    onSecondary: MyColors.white1,
    error: Colors.white,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: MyColors.black1,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: MyColors.white1,
    onPrimary: MyColors.black1,
    secondary: Colors.green, // MyColors.white1
    onSecondary: MyColors.black1,
    error: Colors.black,
    onError: MyColors.red1,
    surface: MyColors.black1,
    onSurface: Colors.white,
  );
}
