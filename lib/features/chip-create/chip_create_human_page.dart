import 'package:flutter/material.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import 'views/section_view.dart';
import 'views/field_view.dart';
import 'views/upload_view.dart';
import 'views/selection_view.dart';
import 'chip_create_human_view_model.dart';

class ChipCreateHumanPage extends StatefulWidget {
  const ChipCreateHumanPage({super.key, required this.vm});

  final ChipCreateHumanViewModel vm;

  ChipCreateHumanPage.create({super.key, required Networkable network})
    : vm = ChipCreateHumanViewModel(network: network);

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
      appBar: AppBar(title: Text('Create Human')),
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SectionView(
                  title: 'Add Image',
                  children: [
                    UploadView(
                      images: widget.vm.uploads,
                      imageChoosed: widget.vm.didChooseImage,
                      info: 'Please add a clear character image.',
                    ),
                  ],
                ),

                SectionView(
                  title: 'Basic Information',
                  children: [
                    FieldView(
                      title: 'Image Frame Name',
                      child: TextField(
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray800),
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          hintText: 'Enter image box name',
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
                      title: 'Gender',
                      child: SelectionView(
                        count: Gender.values.length,
                        per: 2,
                        height: 60,
                        spacing: 8,
                        selected: widget.vm.gender?.index,
                        itemBuilder: (i) => SelectionEntryView(
                          lead: Text(
                            Gender.fromIndex(i).title(context),
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.white100),
                          ),
                          trail: Image.asset(Gender.fromIndex(i).image),
                        ),
                        selectAction: (i) => widget.vm.gender = Gender.fromIndex(i),
                      ),
                    ),
                  ],
                ),
              ],
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
