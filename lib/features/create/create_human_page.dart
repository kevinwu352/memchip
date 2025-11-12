import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import '/utils/event_bus.dart';
import '/utils/router.dart';
import 'views/section_view.dart';
import 'views/field_view.dart';
import 'views/upload_view.dart';
import 'views/round_sel_view.dart';
import 'create_human_vm.dart';
import 'gender.dart';

class CreateHumanPage extends StatefulWidget {
  const CreateHumanPage({super.key, required this.network});
  final Networkable network;

  @override
  State<CreateHumanPage> createState() => _CreateHumanPageState();
}

class _CreateHumanPageState extends State<CreateHumanPage> {
  late final vm = CreateHumanVm(network: widget.network);

  @override
  void initState() {
    super.initState();
    _subscribeSnack();
    _subscribeDone();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.create_page_title)),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SectionView(
                    title: AppLocalizations.of(context)!.create_image_title,
                    children: [
                      UploadView(
                        images: vm.uploads,
                        imageChoosed: vm.didChooseImage,
                        info: AppLocalizations.of(context)!.create_image_info_human,
                      ),
                    ],
                  ),

                  SectionView(
                    title: AppLocalizations.of(context)!.create_basic_title,
                    children: [
                      FieldView(
                        title: AppLocalizations.of(context)!.create_name_title_human,
                        child: TextField(
                          controller: vm.nameController,
                          onChanged: vm.nameChanged,
                          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.create_name_ph_human,
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
                        title: AppLocalizations.of(context)!.create_gender_title,
                        child: RoundSelView(
                          count: Gender.values.length,
                          per: 2,
                          height: 60,
                          spacing: 8,
                          selected: vm.gender?.index,
                          itemBuilder: (i) => RoundSelEntryView(
                            lead: Text(
                              Gender.fromIndex(i).human(context),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.white100),
                            ),
                            trail: Image.asset(Gender.fromIndex(i).image),
                          ),
                          selectAction: (i) => vm.gender = Gender.fromIndex(i),
                        ),
                      ),

                      FieldView(
                        title: AppLocalizations.of(context)!.create_age_title,
                        child: DropdownMenu(
                          onSelected: (value) => vm.age = value,
                          dropdownMenuEntries: Age.values
                              .map((e) => DropdownMenuEntry(value: e, label: e.title(context)))
                              .toList(),
                          expandedInsets: EdgeInsets.zero,
                          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                          hintText: AppLocalizations.of(context)!.create_age_ph,
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
                        title: AppLocalizations.of(context)!.create_figure_title,
                        child: RoundSelView(
                          count: Figure.values.length,
                          per: 2,
                          height: 100,
                          spacing: 6,
                          selected: vm.figure?.index,
                          itemBuilder: (i) => RoundSelEntryView(
                            lead: Text(
                              Figure.fromIndex(i).title(context),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.white100),
                            ),
                            trail: Image.asset(Figure.fromIndex(i).image),
                          ),
                          selectAction: (i) => vm.figure = Figure.fromIndex(i),
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
                            onPressed: () => context.pop(),
                            style: OutlinedButton.styleFrom(side: BorderSide(color: MyColors.violet300, width: 1)),
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: MyColors.violet300),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: vm.submitEnabled ? vm.submitAction : null,
                            style: FilledButton.styleFrom(backgroundColor: MyColors.violet300),
                            child: vm.submiting
                                ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                                : Text(
                                    AppLocalizations.of(context)!.create_create_btn,
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
    vm.snackPub.addListener(() {
      final msg = vm.snackPub.value?.localized(context);
      if (msg != null && msg.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
      }
      vm.snackPub.value = null;
    });
  }

  void _subscribeDone() {
    vm.donePub.addListener(() {
      if (vm.donePub.value) {
        Future.delayed(Duration(seconds: 1), () {
          if (mounted) {
            context.read<EventBus>().fire(type: EventType.boxCreated);
            context.go(Routes.home);
          }
        });
      }
    });
  }
}
