import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var kScreenW = 0.0;
var kScreenH = 0.0;
var kSafeTop = 0.0;
var kSafeBot = 0.0;
void initScreenMetrics(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  kScreenW = size.width;
  kScreenH = size.height;
  if (kDebugMode) debugPrint('screen: $kScreenW,$kScreenH');
  final insets = MediaQuery.viewPaddingOf(context);
  kSafeTop = insets.top;
  kSafeBot = insets.bottom;
  if (kDebugMode) debugPrint('safe: $kSafeTop,$kSafeBot');
}
