import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import 'views/section_view.dart';
import 'views/field_view.dart';
import 'views/upload_view.dart';
import 'views/round_sel_view.dart';
import 'chip_create_human_vm.dart';
import 'gender.dart';

class ChipCreateHumanPage extends StatefulWidget {
  const ChipCreateHumanPage({super.key, required this.vm});

  final ChipCreateHumanVm vm;

  ChipCreateHumanPage.create({super.key, required Networkable network}) : vm = ChipCreateHumanVm(network: network);

  @override
  State<ChipCreateHumanPage> createState() => _ChipCreateHumanPageState();
}

class _ChipCreateHumanPageState extends State<ChipCreateHumanPage> {
  @override
  void initState() {
    super.initState();
    _subscribeSnack();
  }

  @override
  void dispose() {
    widget.vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chip_create_page_title)),
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: (context, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SectionView(
                    title: AppLocalizations.of(context)!.chip_create_image_title,
                    children: [
                      UploadView(
                        images: widget.vm.uploads,
                        imageChoosed: widget.vm.didChooseImage,
                        info: AppLocalizations.of(context)!.chip_create_image_info_human,
                      ),
                    ],
                  ),

                  SectionView(
                    title: AppLocalizations.of(context)!.chip_create_basic_title,
                    children: [
                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_name_title_human,
                        child: TextField(
                          controller: widget.vm.nameController,
                          onChanged: widget.vm.nameChanged,
                          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.chip_create_name_ph_human,
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
                            constraints: BoxConstraints(maxHeight: 36),
                          ),
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_gender_title,
                        child: RoundSelView(
                          count: Gender.values.length,
                          per: 2,
                          height: 60,
                          spacing: 8,
                          selected: widget.vm.gender?.index,
                          itemBuilder: (i) => RoundSelEntryView(
                            lead: Text(
                              Gender.fromIndex(i).human(context),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.white100),
                            ),
                            trail: Image.asset(Gender.fromIndex(i).image),
                          ),
                          selectAction: (i) => widget.vm.gender = Gender.fromIndex(i),
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_age_title,
                        child: DropdownMenu(
                          dropdownMenuEntries: Age.entries,
                          expandedInsets: EdgeInsets.zero,
                          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                          hintText: AppLocalizations.of(context)!.chip_create_age_ph,
                          inputDecorationTheme: InputDecorationThemeData(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.gray300, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxHeight: 36),
                            isCollapsed: true,
                            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray400),
                          ),
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_figure_title,
                        child: RoundSelView(
                          count: Figure.values.length,
                          per: 2,
                          height: 100,
                          spacing: 6,
                          selected: widget.vm.figure?.index,
                          itemBuilder: (i) => RoundSelEntryView(
                            lead: Text(
                              Figure.fromIndex(i).title(context),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.white100),
                            ),
                            trail: Image.asset(Figure.fromIndex(i).image),
                          ),
                          selectAction: (i) => widget.vm.figure = Figure.fromIndex(i),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 24),
                    child: Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(side: BorderSide(color: MyColors.violet300, width: 1)),
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.violet300),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: widget.vm.submitEnabled ? widget.vm.submitAction : null,
                            style: FilledButton.styleFrom(backgroundColor: MyColors.violet300),
                            child: Text(
                              AppLocalizations.of(context)!.chip_create_create_btn,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _subscribeSnack() {
    widget.vm.snackPub.addListener(() {
      final msg = widget.vm.snackPub.value?.localized(context);
      if (msg != null && msg.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
      }
      widget.vm.snackPub.value = null;
    });
  }
}
