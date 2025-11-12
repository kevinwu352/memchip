import 'package:flutter/material.dart';
import '/network/network.dart';

extension BuildContextExt on BuildContext {
  void showSnack(dynamic msg) {
    String? info;
    if (msg is String) {
      info = msg;
    } else if (msg is HttpError) {
      info = msg.localized(this);
    }
    if (info != null && info.isNotEmpty) {
      ScaffoldMessenger.of(this).hideCurrentSnackBar();
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(info), behavior: SnackBarBehavior.floating));
    }
  }
}
