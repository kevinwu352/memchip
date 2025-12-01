import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum _Keys { boardedVersion, lastUsername, accessToken }

final class Secures extends ChangeNotifier {
  Secures({bool onDisk = true}) {
    _raw = onDisk ? FlutterSecureStorage() : null;
  }
  FlutterSecureStorage? _raw;

  Future<void> init() async {
    // await _raw?.write(key: _Keys.boardedVersion.name, value: null);
    // await _raw?.write(key: _Keys.lastUsername.name, value: null);
    // await _raw?.write(key: _Keys.accessToken.name, value: null);
    if (kDebugMode) debugPrint('Secures: ${await _raw?.readAll()}');

    _boardedVersion = await _raw?.read(key: _Keys.boardedVersion.name);
    _lastUsername = await _raw?.read(key: _Keys.lastUsername.name);
    _accessToken = await _raw?.read(key: _Keys.accessToken.name);
  }

  String? _boardedVersion;
  String? get boardedVersion => _boardedVersion;
  set boardedVersion(String? value) {
    _boardedVersion = value;
    _raw?.write(key: _Keys.boardedVersion.name, value: value);
    notifyListeners();
  }

  String? _lastUsername;
  String? get lastUsername => _lastUsername;
  set lastUsername(String? value) {
    _lastUsername = value;
    _raw?.write(key: _Keys.lastUsername.name, value: value);
    notifyListeners();
  }

  String? _accessToken;
  String? get accessToken => _accessToken;
  set accessToken(String? value) {
    _accessToken = value;
    _raw?.write(key: _Keys.accessToken.name, value: value);
    notifyListeners();
  }
}

// ================================================================================

const kCurrentAppVersion = '0.1.0';

extension SecuresExt on Secures {
  bool get showOnboard {
    final boarded = boardedVersion ?? '';
    if (boarded.isEmpty) {
      return true;
    } else {
      final current = kCurrentAppVersion;
      if (current.isNotEmpty) {
        return boarded.versionNum < current.versionNum;
      }
    }
    return false;
  }

  void didOnboard() {
    boardedVersion = kCurrentAppVersion;
  }

  bool get showLogin => (lastUsername ?? '').isEmpty;
  bool get logined => lastUsername?.isNotEmpty == true;
}

extension StringVersionExt on String {
  // '1.2.3' => 1002003
  int get versionNum => split('.').map((e) => int.parse(e)).fold(0, (p, e) => p * 1000 + e);
}
