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
