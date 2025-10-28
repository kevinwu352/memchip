import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var kSafeTop = 0.0;
var kSafeBot = 0.0;
void initSafeMetrics(BuildContext context) {
  final insets = MediaQuery.viewPaddingOf(context);
  kSafeTop = insets.top;
  kSafeBot = insets.bottom;
  if (kDebugMode) debugPrint('safe: $kSafeTop,$kSafeBot');
}
