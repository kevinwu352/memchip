import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '/core/core.dart';
import 'endpoint.dart';
import 'error.dart';
import 'response.dart';

abstract class Networkable {
  Future<Result<Response>> reqRaw(Endpoint api);
  Future<Result<Res>> reqRes<T>(Endpoint api, [T Function(Map<String, dynamic>)? init]);
}

final class HttpClient implements Networkable {
  HttpClient({required this.host, required this.headers});

  final String host;
  final Map<String, String> headers;

  HttpClient.token(String? token) : host = 'dummyjson.com', headers = {'token': ?token};
  // HttpClient.token(String? token) : host = 'www.testingmcafeesites.com', headers = {'token': ?token};

  void setToken(String? token) {
    if (token is String) {
      headers['token'] = token;
    } else {
      headers.remove('token');
    }
  }

  @override
  Future<Result<Response>> reqRaw(Endpoint api) async {
    try {
      final response = await _req(api);
      return Result.ok(response);
    } catch (e) {
      final error = e is HttpError ? e : HttpError.unknownError();
      return Result.error(error);
    }
  }

  @override
  Future<Result<Res>> reqRes<T>(Endpoint api, [T Function(Map<String, dynamic>)? init]) async {
    try {
      final response = await _req(api);
      final res = await compute((message) => parse(message, init), response.body);
      return Result.ok(res);
    } catch (e) {
      final error = e is HttpError ? e : HttpError.unknownError();
      return Result.error(error);
    }
  }

  Future<Response> _req(Endpoint api) async {
    try {
      final Response response;
      switch (api.method) {
        case ReqMethod.get:
          final uri = Uri(scheme: 'https', host: host, path: api.path, queryParameters: api.query());
          response = await get(uri, headers: api.heads(headers)).timeout(Duration(seconds: 15));
        case ReqMethod.post:
          final uri = Uri(scheme: 'https', host: host, path: api.path);
          response = await post(uri, headers: api.heads(headers), body: api.body()).timeout(Duration(seconds: 15));
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw HttpError.statusError();
      }
    } catch (e) {
      throw e is HttpError ? e : HttpError.networkError();
    }
  }
}
