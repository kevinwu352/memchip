import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/pch.dart';
import 'detail_vm.dart';
import 'views/unknown_view.dart';
import 'views/activated_view.dart';
import 'views/previewed_view.dart';
import 'views/generated_view.dart';
import 'views/selection_view.dart';

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
    onComplete: () =>
        Future.delayed(Duration(seconds: 1), () => mounted ? context.fire(EventType.boxDeleted).pop() : null),
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
        actions: [IconButton(onPressed: deleteAction, icon: Icon(Icons.delete))],
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) => IndexedStack(
          index: vm.box.status.stack,
          sizing: StackFit.expand,
          children: [
            UnknownView(url: vm.box.coverImage, action: () {}),
            ActivatedView(url: vm.box.coverImage, action: () {}),
            PreviewedView(action: () {}),
            GeneratedView(
              url: '',
              action: () {
                showModalBottomSheet(
                  backgroundColor: MyColors.violet00,
                  context: context,
                  builder: (context) {
                    // return Text('abc');
                    return SelectionView(
                      items: ['data 1', 'data 2', 'data 3', 'data 4', 'data 5'],
                      selected: 1,
                      onSelect: (value) {},
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void deleteAction() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        title: Text(AppLocalizations.of(context)!.detail_delete_title),
        content: Text(AppLocalizations.of(context)!.detail_delete_info),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              vm.deleteAction();
            },
            child: Text(AppLocalizations.of(context)!.confirm),
          ),
        ],
      ),
    );
  }
}
