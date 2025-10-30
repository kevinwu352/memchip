import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/theme/theme.dart';

class ChipCategoryPage extends StatelessWidget {
  const ChipCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chip_category_page_title)),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              ..._Entry.values.map(
                (it) => _EntryView(
                  cover: it.cover,
                  info: it.info(context),
                  button: it.button(context),
                  action: () => print(it),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Entry {
  human,
  pet;

  String get cover {
    switch (this) {
      case human:
        return 'assets/images/category_human.png';
      case pet:
        return 'assets/images/category_pet.png';
    }
  }

  String info(BuildContext context) {
    switch (this) {
      case human:
        return AppLocalizations.of(context)!.chip_category_human_info;
      case pet:
        return AppLocalizations.of(context)!.chip_category_pet_info;
    }
  }

  String button(BuildContext context) {
    switch (this) {
      case human:
        return AppLocalizations.of(context)!.chip_category_human_btn;
      case pet:
        return AppLocalizations.of(context)!.chip_category_pet_btn;
    }
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({required this.cover, required this.info, required this.button, required this.action});

  final String cover;
  final String info;
  final String button;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 280 / 202,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(cover))),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                info,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: MyColors.white80),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: MyColors.orange400,
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: action,
                child: Text(button, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
