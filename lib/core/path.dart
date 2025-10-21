import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

var _docroot = '';

Future<void> pathinit() async {
  final dir = await getApplicationDocumentsDirectory();
  _docroot = dir.path;
  if (kDebugMode) debugPrint(_docroot);
}

String pathmk(String part2, [String? part3, String? part4, String? part5]) =>
    join(_docroot, part2, part3, part4, part5);
