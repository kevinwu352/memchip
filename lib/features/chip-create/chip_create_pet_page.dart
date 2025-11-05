import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/network/network.dart';
import 'chip_create_pet_vm.dart';

class ChipCreatePetPage extends StatefulWidget {
  const ChipCreatePetPage({super.key, required this.vm});

  final ChipCreatePetVm vm;

  ChipCreatePetPage.create({super.key, required Networkable network}) : vm = ChipCreatePetVm(network: network);

  @override
  State<ChipCreatePetPage> createState() => _ChipCreatePetPageState();
}

class _ChipCreatePetPageState extends State<ChipCreatePetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chip_create_page_title)),
      body: Text('--'),
    );
  }
}
