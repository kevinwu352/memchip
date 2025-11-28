import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '/core/core.dart';
import 'endpoint.dart';
import 'error.dart';
import 'response.dart';

final kCurrentHost = 'apiuniapp.paoxiaokeji.com';

abstract class Networkable {
  Future<Result<Res>> req<T>(Endpoint api, {T Function(Map<String, dynamic>)? init, String? key});
}

final class HttpClient implements Networkable {
  HttpClient({required this.host, required this.headers});

  final String host;
  final Map<String, String> headers;

  HttpClient.token(String? token) : host = kCurrentHost, headers = {'token': ?token};

  String? get token => headers['token'];
  set token(String? value) {
    // print('set-token: $value');
    if (value is String) {
      headers['token'] = value;
    } else {
      headers.remove('token');
    }
  }

  String? get local => headers['lan'];
  set local(String? value) {
    // print('set-local: $value');
    if (value is String) {
      headers['lan'] = value;
    } else {
      headers.remove('lan');
    }
  }

  @override
  Future<Result<Res>> req<T>(Endpoint api, {T Function(Map<String, dynamic>)? init, String? key}) async {
    try {
      final response = await _req(api);
      final res = await compute((message) => Res.parse(message, init: init, key: key), response.body);
      return Result.ok(res);
    } catch (e) {
      final error = e is HttpError ? e : HttpError.unknown;
      return Result.error(error);
    }
  }

  Future<Response> _req(Endpoint api) async {
    try {
      final Response response;
      switch (api.method) {
        case ReqMethod.get:
          final uri = Uri(scheme: 'https', host: host, path: api.path, queryParameters: api.query());
          response = await get(uri, headers: api.heads(headers)).timeout(Duration(seconds: 120));
        case ReqMethod.post:
          final uri = Uri(scheme: 'https', host: host, path: api.path);
          response = await post(uri, headers: api.heads(headers), body: api.body()).timeout(Duration(seconds: 120));
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw HttpError.status;
      }
    } catch (e) {
      throw e is HttpError ? e : HttpError.network;
    }
  }
}
