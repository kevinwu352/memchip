import 'package:flutter/material.dart';
import '/network/network.dart';

final class RegisterVm extends ChangeNotifier {
  RegisterVm({required Networkable network}) : _network = network;
  final Networkable _network;
}
