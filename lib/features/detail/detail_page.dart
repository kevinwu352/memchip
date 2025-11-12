import 'package:flutter/material.dart';
import '/pch.dart';
import 'detail_vm.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.box, required this.network});
  final Box box;
  final Networkable network;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final vm = DetailVm(network: widget.network);

  @override
  void initState() {
    super.initState();
    _subscribeSnack();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('detail')),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) => SizedBox.expand(
          child: Column(
            children: [
              //
              Text('data: ${widget.box.boxName}'),
            ],
          ),
        ),
      ),
    );
  }

  void _subscribeSnack() {
    vm.snackPub.addListener(() {
      final msg = vm.snackPub.value?.localized(context);
      if (msg != null && msg.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
      }
      vm.snackPub.value = null;
    });
  }
}
