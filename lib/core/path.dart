import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

var _docroot = '';

Future<void> pathInit() async {
  final dir = await getApplicationDocumentsDirectory();
  _docroot = dir.path;
  if (kDebugMode) debugPrint(_docroot);
}

String pathmk(String part2, [String? part3, String? part4, String? part5]) =>
    join(_docroot, part2, part3, part4, part5);

Future<bool> direExist(String path) async {
  final dir = Directory(path);
  final exist = await dir.exists();
  return exist;
}

Future<bool> fileExist(String path) async {
  final fil = File(path);
  final exist = await fil.exists();
  return exist;
}

Future<void> direCreate(String path) async {
  final dir = Directory(path);
  final exist = await dir.exists();
  if (!exist) {
    await dir.create(recursive: true);
  }
}
