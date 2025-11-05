import 'dart:collection';
import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/image_uploader.dart';

final class ChipCreateHumanViewModel extends ChangeNotifier {
  ChipCreateHumanViewModel({required Networkable network}) : _network = network {
    for (var element in uploads) {
      element.notify = notifyListeners;
    }
  }
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<ImageUploader> uploads = [ImageUploader()];

  Gender? _gender;
  Gender? get gender => _gender;
  set gender(Gender? value) {
    _gender = value;
    notifyListeners();
  }

  void didChooseImage(int index, String path) async {
    uploads[index].launch(path, notifyListeners);
  }
}

enum Gender {
  male,
  female;

  factory Gender.fromIndex(int i) => Gender.values[i];

  String title(BuildContext context) {
    switch (this) {
      case male:
        return AppLocalizations.of(context)!.chip_create_gender_male;
      case female:
        return AppLocalizations.of(context)!.chip_create_gender_female;
    }
  }

  String get image {
    switch (this) {
      case male:
        return 'assets/images/create_sex_male.png';
      case female:
        return 'assets/images/create_sex_female.png';
    }
  }
}

enum AgeRange {
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

  static List<DropdownMenuEntry<AgeRange>> entries = UnmodifiableListView<DropdownMenuEntry<AgeRange>>(
    values.map((e) => DropdownMenuEntry(value: e, label: e.title)),
  );
}
