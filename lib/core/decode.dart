import 'dart:convert';

typedef FromJson<T> = T Function(Map<String, dynamic>);

T json2obj<T>(Map<String, dynamic> json, FromJson<T> fromJson) {
  return fromJson(json);
}

List<T> json2list<T>(List<dynamic> json, FromJson<T> fromJson) {
  return json.whereType<Map>().map((e) => fromJson(e.map((k, v) => MapEntry(k.toString(), v)))).toList();
}

// ================================================================================

T str2obj<T>(String str, FromJson<T> fromJson) {
  Map<String, dynamic> json = jsonDecode(str);
  return json2obj(json, fromJson);
}

List<T> str2list<T>(String str, FromJson<T> fromJson) {
  List<dynamic> json = jsonDecode(str);
  return json2list(json, fromJson);
}

T key2obj<T>(String str, String key, FromJson<T> fromJson) {
  Map<String, dynamic> json = jsonDecode(str);
  Map<String, dynamic> map = json[key];
  return json2obj(map, fromJson);
}

List<T> key2list<T>(String str, String key, FromJson<T> fromJson) {
  Map<String, dynamic> json = jsonDecode(str);
  List<dynamic> list = json[key];
  return json2list(list, fromJson);
}
