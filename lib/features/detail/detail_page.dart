import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/pch.dart';
import 'detail_vm.dart';
import 'gest.dart';
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
    onDeleted: () =>
        Future.delayed(Duration(seconds: 1), () => mounted ? context.fire(EventType.boxDeleted).pop() : null),
    onUpdated: () => context.fire(EventType.boxUpdated),
    onShowSelect: _showSelect,
    onShowGenerating: _showGenerating,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.box.name),
        actions: vm.box.status == BoxStatus.unknown ? [IconButton(onPressed: _delete, icon: Icon(Icons.delete))] : null,
      ),
      resizeToAvoidBottomInset: false,
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) => IndexedStack(
          index: vm.box.status.stack,
          sizing: StackFit.expand,
          children: [
            UnknownView(url: vm.box.coverImage, doing: vm.activating, onPressed: _activate),

            ActivatedView(url: vm.box.coverImage, doing: vm.previewing, onPressed: vm.previewAction),

            PreviewedView(
              items: vm.box.previewImages,
              selected: vm.selectedPreview,
              onSelected: vm.selectPreview,
              generating: vm.box.status == BoxStatus.generating,
              onPressed: vm.generateEnabled ? vm.generateAction : null,
            ),

            GeneratedView(url: '', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void _delete() {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        title: Text(AppLocalizations.of(context)!.detail_delete_alert_title),
        content: Text(AppLocalizations.of(context)!.detail_delete_alert_info),
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

  void _activate() {
    if (vm.activating) return;
    vm.serialController.text = '';
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        title: Text(AppLocalizations.of(context)!.detail_activate_alert_title),
        content: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: vm.serialController,
              onChanged: vm.serialChanged,
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: false,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.gray100,
                hintText: 'A1B2C3D4',
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray400),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.gray300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.violet200, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                constraints: BoxConstraints(maxHeight: 40),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              vm.activateAction();
            },
            child: Text(AppLocalizations.of(context)!.confirm),
          ),
        ],
      ),
    );
  }

  Future<List<Gest>?> _showSelect() {
    return showModalBottomSheet<List<Gest>>(
      backgroundColor: MyColors.violet00,
      context: context,
      builder: (context) => SelectionView(items: vm.gests),
    );
  }

  void _showGenerating() {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        title: Text(AppLocalizations.of(context)!.detail_generating_alert_title),
        content: Text(AppLocalizations.of(context)!.detail_generating_alert_info),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.confirm)),
        ],
      ),
    );
  }
}
