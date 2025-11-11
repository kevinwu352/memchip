import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/l10n/localizations.dart';
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
  void initState() {
    super.initState();
    _subscribeSnack();
    _subscribeDone();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register_page_title)),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
            Text('data'),
          ],
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

  void _subscribeDone() {
    vm.donePub.addListener(() {
      if (vm.donePub.value) {
        context.pop();
      }
    });
  }
}
