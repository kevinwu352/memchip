import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';

final class RegisterVm extends ChangeNotifier {
  RegisterVm({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);
  ValueNotifier<bool> donePub = ValueNotifier(false);
}
