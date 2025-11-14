import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/network/network.dart';
import 'event_bus.dart';

extension BuildContextExt on BuildContext {
  BuildContext showSnack(dynamic msg) {
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
    return this;
  }

  BuildContext fire(EventType type) {
    read<EventBus>().fire(type: type);
    return this;
  }
}
