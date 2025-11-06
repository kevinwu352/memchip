import 'package:flutter/material.dart';
import '/l10n/localizations.dart';

enum Gender {
  male,
  female;

  factory Gender.fromIndex(int i) => Gender.values[i];

  String human(BuildContext context) {
    switch (this) {
      case male:
        return AppLocalizations.of(context)!.create_gender_male_human;
      case female:
        return AppLocalizations.of(context)!.create_gender_female_human;
    }
  }

  String pet(BuildContext context) {
    switch (this) {
      case male:
        return AppLocalizations.of(context)!.create_gender_male_pet;
      case female:
        return AppLocalizations.of(context)!.create_gender_female_pet;
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

  String get serval {
    switch (this) {
      case male:
        return 'male';
      case female:
        return 'female';
    }
  }
}
