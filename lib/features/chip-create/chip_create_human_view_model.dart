import 'package:flutter/material.dart';
import '/network/network.dart';

final class ChipCreateHumanViewModel extends ChangeNotifier {
  ChipCreateHumanViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

  // ValueNotifier<Localable?> snackPub = ValueNotifier(null);
}
