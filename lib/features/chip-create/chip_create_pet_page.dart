import 'package:flutter/material.dart';
import '/l10n/localizations.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import 'views/section_view.dart';
import 'views/field_view.dart';
import 'views/upload_view.dart';
import 'views/round_sel_view.dart';
import 'views/line_sel_view.dart';
import 'views/char_view.dart';
import 'chip_create_pet_vm.dart';
import 'gender.dart';

class ChipCreatePetPage extends StatefulWidget {
  const ChipCreatePetPage({super.key, required this.vm});

  final ChipCreatePetVm vm;

  ChipCreatePetPage.create({super.key, required Networkable network}) : vm = ChipCreatePetVm(network: network);

  @override
  State<ChipCreatePetPage> createState() => _ChipCreatePetPageState();
}

class _ChipCreatePetPageState extends State<ChipCreatePetPage> {
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
                        info: AppLocalizations.of(context)!.chip_create_image_info_pet,
                      ),
                    ],
                  ),

                  SectionView(
                    title: AppLocalizations.of(context)!.chip_create_basic_title,
                    children: [
                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_name_title_pet,
                        child: TextField(
                          controller: widget.vm.nameController,
                          onChanged: widget.vm.nameChanged,
                          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.chip_create_name_ph_pet,
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
                              Gender.fromIndex(i).pet(context),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.white100),
                            ),
                            trail: Image.asset(Gender.fromIndex(i).image),
                          ),
                          selectAction: (i) => widget.vm.gender = Gender.fromIndex(i),
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_species_title,
                        child: RoundSelView(
                          count: Species.values.length,
                          per: 3,
                          height: 86,
                          spacing: 8,
                          selected: widget.vm.species?.index,
                          normalColor: MyColors.violet100,
                          selectedColor: MyColors.orange300,
                          itemBuilder: (i) => RoundSelEntryView(
                            axis: Axis.vertical,
                            compact: true,
                            lead: Image.asset(Species.fromIndex(i).image),
                            trail: Text(
                              Species.fromIndex(i).title(context),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.white100),
                            ),
                          ),
                          selectAction: (i) => widget.vm.species = Species.fromIndex(i),
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_tail_title,
                        child: LineSelView(
                          children: [
                            LineSelEntryView(
                              icon: 'assets/images/create_tail_yes.png',
                              name: 'With tail',
                              selected: widget.vm.withTail == true,
                              action: () => widget.vm.withTail = true,
                            ),
                            LineSelEntryView(
                              icon: 'assets/images/create_tail_no.png',
                              name: 'No tail',
                              selected: widget.vm.withTail == false,
                              action: () => widget.vm.withTail = false,
                            ),
                          ],
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.chip_create_personality_title,
                        child: CharView(
                          children: [
                            ...Personality.values.map(
                              (e) => CharEntryView(
                                title: e.title(context),
                                selected: e == widget.vm.personality,
                                action: () => widget.vm.personality = e,
                              ),
                            ),
                          ],
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
