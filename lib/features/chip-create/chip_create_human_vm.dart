import 'dart:collection';
import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/image_uploader.dart';
import 'gender.dart';

final class ChipCreateHumanVm extends ChangeNotifier {
  ChipCreateHumanVm({required Networkable network}) : _network = network {
    for (var element in uploads) {
      element.notify = notifyListeners;
    }
  }
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<ImageUploader> uploads = [ImageUploader()];
  void didChooseImage(int index, String path) async {
    uploads[index].launch(path, notifyListeners);
  }

  final nameController = TextEditingController();
  void nameChanged(String value) {
    notifyListeners();
  }

  Gender? _gender;
  Gender? get gender => _gender;
  set gender(Gender? value) {
    _gender = value;
    notifyListeners();
  }

  Age? _age;
  Age? get age => _age;
  set age(Age? value) {
    _age = value;
    notifyListeners();
  }

  Figure? _figure;
  Figure? get figure => _figure;
  set figure(Figure? value) {
    _figure = value;
    notifyListeners();
  }

  bool get submitEnabled {
    return uploads.every((e) => e.success == true) &&
        nameController.text.isNotEmpty &&
        _gender != null &&
        _age != null &&
        _figure != null;
  }

  var _submiting = false;
  bool get submiting => _submiting;
  set submiting(bool value) {
    _submiting = value;
    notifyListeners();
  }

  void submitAction() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_submiting) return;
    print('do submit');
  }

  @override
  void dispose() {
    nameController.dispose();
    snackPub.dispose();
    super.dispose();
  }
}

enum Age {
  range0,
  range13,
  range18,
  range25,
  range35,
  range60;

  String get title {
    switch (this) {
      case range0:
        return '0-12';
      case range13:
        return '13-17';
      case range18:
        return '18-24';
      case range25:
        return '25-34';
      case range35:
        return '35-59';
      case range60:
        return '60+';
    }
  }

  static List<DropdownMenuEntry<Age>> entries = UnmodifiableListView<DropdownMenuEntry<Age>>(
    values.map((e) => DropdownMenuEntry(value: e, label: e.title)),
  );
}

enum Figure {
  slim,
  standard,
  fit,
  chubby;

  factory Figure.fromIndex(int i) => Figure.values[i];

  String title(BuildContext context) {
    switch (this) {
      case slim:
        return AppLocalizations.of(context)!.chip_create_figure_1;
      case standard:
        return AppLocalizations.of(context)!.chip_create_figure_2;
      case fit:
        return AppLocalizations.of(context)!.chip_create_figure_3;
      case chubby:
        return AppLocalizations.of(context)!.chip_create_figure_4;
    }
  }

  String get image {
    switch (this) {
      case slim:
        return 'assets/images/create_figure_1.png';
      case standard:
        return 'assets/images/create_figure_2.png';
      case fit:
        return 'assets/images/create_figure_3.png';
      case chubby:
        return 'assets/images/create_figure_4.png';
    }
  }
}
