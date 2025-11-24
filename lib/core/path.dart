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

Future<bool> fileExist(String path) async => File(path).exists();
bool fileExistSync(String path) => File(path).existsSync();

Future<bool> dirExist(String path) async => Directory(path).exists();
bool dirExistSync(String path) => Directory(path).existsSync();
Future<void> dirCreate(String path) async {
  final dir = Directory(path);
  if (!dir.existsSync()) {
    await dir.create(recursive: true);
  }
}
