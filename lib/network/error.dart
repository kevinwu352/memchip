import 'package:flutter/material.dart';
import 'package:memchip/l10n/localizations.dart';
import '/core/core.dart';

class HttpError implements Exception, Localizable {
  const HttpError._(this.code, this.info);
  final int code;
  final String info;

  factory HttpError.unknownError() => HttpError._(10000, 'Unknown Error');
  factory HttpError.networkError() => HttpError._(10001, 'Network Error');
  factory HttpError.statusError() => HttpError._(10002, 'Status Error');
  factory HttpError.decodeError() => HttpError._(10003, 'Decode Error');
  factory HttpError.operationFailed() => HttpError._(10004, 'Operation Failed');

  @override
  String toString() => info;

  @override
  String localized(BuildContext context) {
    switch (code) {
      case 10001:
        return AppLocalizations.of(context)!.http_error_network;
      case 10002:
        return AppLocalizations.of(context)!.http_error_status;
      case 10003:
        return AppLocalizations.of(context)!.http_error_decode;
      case 10004:
        return AppLocalizations.of(context)!.http_error_operation;
      default:
        return AppLocalizations.of(context)!.http_error_unknown;
    }
  }
}
