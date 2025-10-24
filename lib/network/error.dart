class HttpError implements Exception {
  const HttpError._(this.info);
  final String info;

  factory HttpError.networkError() => HttpError._('Network Error');
  factory HttpError.statusError() => HttpError._('Status Error');
  factory HttpError.decodeError() => HttpError._('Decode Error');
  factory HttpError.operationFailed() => HttpError._('Operation Failed');

  factory HttpError.unknownError() => HttpError._('Unknown Error');

  @override
  String toString() => info;
}
