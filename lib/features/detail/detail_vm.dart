import 'package:flutter/material.dart';
import '/pch.dart';

final class DetailVm extends ChangeNotifier {
  DetailVm({required Networkable network, void Function(dynamic msg)? onSnack, void Function()? onComplete})
    : _network = network,
      _onSnack = onSnack,
      _onComplete = onComplete;
  final Networkable _network;

  final void Function(dynamic msg)? _onSnack;
  final void Function()? _onComplete;
}
