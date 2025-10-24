import 'dart:convert';
import 'error.dart';

class Res {
  Res({required this.code, required this.message});

  int code;
  String message;
  Object? data;

  Res.fromJson(Map<String, dynamic> json) : code = json['code'] as int, message = json['message'] as String;

  bool get success => code == 200;

  T? getObject<T>() => data is T ? data as T : null;
  List<T>? getList<T>() => data is List ? (data as List).whereType<T>().toList() : null;
}

// null
// bool/int/double
// string
// object
// array
Res parse<T>(String str, [T Function(Map<String, dynamic>)? init]) {
  try {
    Map<String, Object?> json = jsonDecode(str);
    final res = Res.fromJson(json);
    final data = json['data'];
    if (data is List) {
      if (data.isEmpty) {
        res.data = data;
      } else if (data.every((e) => e == null)) {
        res.data = data;
      } else if (data.every((e) => e is bool?)) {
        res.data = data.whereType<bool?>().toList();
      } else if (data.every((e) => e is int?)) {
        res.data = data.whereType<int?>().toList();
      } else if (data.every((e) => e is double?)) {
        res.data = data.whereType<double?>().toList();
      } else if (data.every((e) => e is num?)) {
        res.data = data.whereType<num?>().toList();
      } else if (data.every((e) => e is String?)) {
        res.data = data.whereType<String?>().toList();
      } else if (data.every((e) => e is Map?)) {
        res.data = data.map((e) => e != null ? init?.call(e) : null).whereType<T?>().toList();
      } else {
        res.data = data; // list? should not be here. fxxk
      }
    } else {
      if (data is Map) {
        res.data = init?.call(data.map((k, v) => MapEntry(k.toString(), v)));
      } else {
        // null, bool, int, double, String
        // can't be any other type. there's no other type, right?
        res.data = data;
      }
    }
    return res;
  } catch (e) {
    throw HttpError.decode;
  }
}
