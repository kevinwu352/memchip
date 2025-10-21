import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

extension StringHashExt on String {
  String get sha1 {
    if (isEmpty) return '';
    final bytes = utf8.encode(this);
    final digest = crypto.sha1.convert(bytes);
    return digest.toString();
  }

  String get md5 {
    if (isEmpty) return '';
    final bytes = utf8.encode(this);
    final digest = crypto.md5.convert(bytes);
    return digest.toString();
  }
}
