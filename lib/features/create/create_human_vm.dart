import 'package:flutter/material.dart';
import '/pch.dart';
import '/utils/image_uploader.dart';
import 'gender.dart';

final class CreateHumanVm extends ChangeNotifier {
  CreateHumanVm({required this.network, this.onSnack, this.onComplete}) {
    for (var element in uploads) {
      element.notify = notifyListeners;
    }
  }
  final Networkable network;
  final void Function(dynamic msg)? onSnack;
  final void Function()? onComplete;

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
    _create(nameController.text, uploads[0].url, _gender?.serval, _age?.serval, _figure?.serval);
  }

  void _create(String name, String? image, String? gender, String? age, String? figure) async {
    try {
      submiting = true;
      final result = await network.reqRes(Api.boxCreateHuman(name, image, gender, age, figure));
      final res = result.val.checked;
      onSnack?.call(res.message);
      onComplete?.call();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      submiting = false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}

enum Age {
  range0,
  range13,
  range18,
  range36,
  range60;

  String title(BuildContext context) {
    switch (this) {
      case range0:
        return AppLocalizations.of(context)!.create_age_range1;
      case range13:
        return AppLocalizations.of(context)!.create_age_range2;
      case range18:
        return AppLocalizations.of(context)!.create_age_range3;
      case range36:
        return AppLocalizations.of(context)!.create_age_range4;
      case range60:
        return AppLocalizations.of(context)!.create_age_range5;
    }
  }

  String get serval {
    switch (this) {
      case range0:
        return '儿童';
      case range13:
        return '青少年';
      case range18:
        return '青年';
      case range36:
        return '中年';
      case range60:
        return '老年';
    }
  }
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
        return AppLocalizations.of(context)!.create_figure1;
      case standard:
        return AppLocalizations.of(context)!.create_figure2;
      case fit:
        return AppLocalizations.of(context)!.create_figure3;
      case chubby:
        return AppLocalizations.of(context)!.create_figure4;
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

  String get serval {
    switch (this) {
      case slim:
        return '偏瘦';
      case standard:
        return '标准';
      case fit:
        return '健壮';
      case chubby:
        return '丰满';
    }
  }
}
