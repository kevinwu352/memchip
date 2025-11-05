import 'package:flutter/material.dart';
import '/network/network.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required Networkable network}) : _network = network;
  final Networkable _network;

  // ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<int> chips = [];
}
