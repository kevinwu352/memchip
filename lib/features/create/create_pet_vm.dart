import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/image_uploader.dart';
import 'gender.dart';

final class CreatePetVm extends ChangeNotifier {
  CreatePetVm({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<ImageUploader> uploads = [ImageUploader(), ImageUploader()];
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

  Species? _species;
  Species? get species => _species;
  set species(Species? value) {
    _species = value;
    notifyListeners();
  }

  bool? _withTail;
  bool? get withTail => _withTail;
  set withTail(bool? value) {
    _withTail = value;
    notifyListeners();
  }

  Personality? _personality;
  Personality? get personality => _personality;
  set personality(Personality? value) {
    _personality = value;
    notifyListeners();
  }

  bool get submitEnabled {
    return uploads.every((e) => e.success == true) &&
        nameController.text.isNotEmpty &&
        _gender != null &&
        _species != null &&
        _withTail != null &&
        _personality != null;
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

enum Species {
  cat,
  dog,
  rabbit,
  parrot,
  hamster,
  other;

  factory Species.fromIndex(int i) => Species.values[i];

  String title(BuildContext context) {
    switch (this) {
      case cat:
        return AppLocalizations.of(context)!.create_species_cat;
      case dog:
        return AppLocalizations.of(context)!.create_species_dog;
      case rabbit:
        return AppLocalizations.of(context)!.create_species_rabbit;
      case parrot:
        return AppLocalizations.of(context)!.create_species_parrot;
      case hamster:
        return AppLocalizations.of(context)!.create_species_hamster;
      case other:
        return AppLocalizations.of(context)!.create_species_other;
    }
  }

  String get image {
    switch (this) {
      case cat:
        return 'assets/images/create_pet_cat.png';
      case dog:
        return 'assets/images/create_pet_dog.png';
      case rabbit:
        return 'assets/images/create_pet_rabbit.png';
      case parrot:
        return 'assets/images/create_pet_parrot.png';
      case hamster:
        return 'assets/images/create_pet_hamster.png';
      case other:
        return 'assets/images/create_pet_other.png';
    }
  }
}

enum Personality {
  playful,
  quiet,
  foodie,
  timid,
  clingy,
  solo,
  naughty,
  tame;

  String title(BuildContext context) {
    switch (this) {
      case playful:
        return AppLocalizations.of(context)!.create_personality_playful;
      case quiet:
        return AppLocalizations.of(context)!.create_personality_quiet;
      case foodie:
        return AppLocalizations.of(context)!.create_personality_foodie;
      case timid:
        return AppLocalizations.of(context)!.create_personality_timid;
      case clingy:
        return AppLocalizations.of(context)!.create_personality_clingy;
      case solo:
        return AppLocalizations.of(context)!.create_personality_solo;
      case naughty:
        return AppLocalizations.of(context)!.create_personality_naughty;
      case tame:
        return AppLocalizations.of(context)!.create_personality_tame;
    }
  }
}
