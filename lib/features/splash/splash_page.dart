import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/pch.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // print('init splash');
  }

  @override
  void dispose() {
    // print('dispose splash');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('splash')),
      body: Center(
        child: TextButton(onPressed: () => context.push(Routes.home), child: Text('home')),
      ),
    );
  }
}
