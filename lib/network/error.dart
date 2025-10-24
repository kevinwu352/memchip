import 'package:flutter/material.dart';
import 'package:memchip/l10n/localizations.dart';
import '/core/core.dart';

enum HttpError implements Exception, Localizable {
  unknown,
  network,
  status,
  decode,
  operation;

  @override
  String? localized(BuildContext? context) {
    if (context != null) {
      switch (this) {
        case unknown:
          return AppLocalizations.of(context)!.http_error_unknown;
        case network:
          return AppLocalizations.of(context)!.http_error_network;
        case status:
          return AppLocalizations.of(context)!.http_error_status;
        case decode:
          return AppLocalizations.of(context)!.http_error_decode;
        case operation:
          return AppLocalizations.of(context)!.http_error_operation;
      }
    } else {
      switch (this) {
        case unknown:
          return 'Unknown Error';
        case network:
          return 'Network Error';
        case status:
          return 'Status Error';
        case decode:
          return 'Decode Error';
        case operation:
          return 'Operation Failed';
      }
    }
  }
}
