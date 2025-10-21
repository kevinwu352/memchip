import 'dart:convert';

enum ReqMethod { get, post }

enum ReqEncoding { url, json }

class Endpoint {
  Endpoint(this.path, this.method, {this.parameters, this.encoding = ReqEncoding.url, this.headers});

  final String path;
  final ReqMethod method;
  final Map<String, dynamic>? parameters;
  final ReqEncoding encoding;
  final Map<String, String>? headers;

  Map<String, String>? heads(Map<String, String>? base) {
    Map<String, String> into = Map.of(headers ?? {});
    if (method == ReqMethod.post && encoding == ReqEncoding.json) {
      into['Content-Type'] = 'application/json; charset=utf-8';
    }
    Map<String, String> map = Map.of(base ?? {})..addAll(into);
    return map.isNotEmpty ? map : null;
  }

  Map<String, dynamic>? query() {
    Map<String, dynamic> map = Map.of(parameters ?? {});
    map.updateAll((key, value) => Uri.encodeComponent(value.toString()));
    return map.isNotEmpty ? map : null;
  }

  // String / Map<String, dynamic>?
  Object? body() {
    Map<String, dynamic> map = Map.of(parameters ?? {});
    if (method == ReqMethod.post && encoding == ReqEncoding.json) {
      return map.isNotEmpty ? jsonEncode(map) : null;
    } else {
      map.updateAll((key, value) => Uri.encodeComponent(value.toString()));
      return map.isNotEmpty ? map : null;
    }
  }
}
