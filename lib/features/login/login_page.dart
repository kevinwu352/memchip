import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(child: Column(children: [SizedBox(height: 32), Image.asset('assets/images/logo.png')])),
      ),
    );
  }
}
