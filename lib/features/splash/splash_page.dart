import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_plus/sensors_plus.dart';
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

    // sub = userAccelerometerEventStream().listen((event) {
    //   final val = 1;
    //   if (event.x > val || event.x < -val || event.y > val || event.y < -val || event.z > val || event.z < -val) {
    //     print(event);
    //   } else {
    //     print('skip');
    //   }
    // });

    // sub = gyroscopeEventStream().listen((event) {
    //   // final val = 0.1;
    //   // if (event.x > val || event.x < -val || event.y > val || event.y < -val || event.z > val || event.z < -val) {
    //   //   print(getstr(event, 0.1));
    //   // } else {
    //   //   print('skip');
    //   // }
    //   print(getstr(event, 0.1));
    // });

    sub = accelerometerEventStream().listen((event) {
      // final val = 1;
      // if (event.x > val || event.x < -val || event.y > val || event.y < -val || event.z > val || event.z < -val) {
      //   print(event);
      // } else {
      //   print('skip');
      // }
      print(getstr(event, 2));
    });
  }

  String getstr(AccelerometerEvent e, double min) {
    final str = [
      e.x > min || e.x < -min ? '${e.x.truncate()}' : '__',
      e.y > min || e.y < -min ? '${e.y.truncate()}' : '__',
      e.z > min || e.z < -min ? '${e.z.truncate()}' : '__',
    ].join(', ');
    return '($str)';
  }

  StreamSubscription? sub;

  @override
  void dispose() {
    // print('dispose splash');
    sub?.cancel();
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
