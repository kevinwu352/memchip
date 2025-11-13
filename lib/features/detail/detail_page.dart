import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/pch.dart';
import 'detail_vm.dart';
import 'views/unknown_view.dart';
import 'views/activated_view.dart';
import 'views/previewed_view.dart';
import 'views/generated_view.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.box, required this.network});
  final Box box;
  final Networkable network;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final vm = DetailVm(
    box: widget.box,
    network: widget.network,
    onSnack: (msg) => context.showSnack(msg),
    onComplete: () {
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          context.read<EventBus>().fire(type: EventType.boxDeleted);
          context.pop();
        }
      });
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.box.boxName),
        actions: [IconButton(onPressed: vm.deleteAction, icon: Icon(Icons.delete))],
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) => IndexedStack(
          index: vm.box.status.stack,
          sizing: StackFit.expand,
          children: [
            UnknownView(url: vm.box.coverImage, action: () {}),
            ActivatedView(url: vm.box.coverImage, action: () {}),
            PreviewedView(),
            GeneratedView(),
          ],
        ),
      ),
    );
  }
}
