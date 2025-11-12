import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';

final class DetailVm extends ChangeNotifier {
  DetailVm({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  @override
  void dispose() {
    snackPub.dispose();
    super.dispose();
  }
}
