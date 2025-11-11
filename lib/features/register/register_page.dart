import 'package:flutter/material.dart';
import '/network/network.dart';
import 'register_vm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.network});
  final Networkable network;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final vm = RegisterVm(network: widget.network);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      backgroundColor: Colors.teal,
      body: Text('--'),
    );
  }
}
