import 'package:flutter/material.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import 'views/section_view.dart';
import 'views/field_view.dart';
import 'views/upload_view.dart';
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
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SectionView(
                  title: 'Add Image',
                  children: [
                    UploadView(
                      images: widget.vm.uploads,
                      imageChoosed: widget.vm.didChooseImage,
                      info: 'Please add a clear character image.',
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: SectionView(
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
                  ],
                ),
              ),

              // SliverPadding(
              //   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              //   sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Add Image')),
              // ),
              // SliverPadding(
              //   padding: const EdgeInsets.symmetric(horizontal: 50),
              //   sliver: SliverToBoxAdapter(
              //     child: UploadView(
              //       images: widget.vm.uploads,
              //       imageChoosed: widget.vm.didChooseImage,
              //       info: 'Please add a clear character image.',
              //     ),
              //   ),
              // ),
              // SliverPadding(
              //   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              //   sliver: SliverToBoxAdapter(child: SectionTitle(title: 'Basic Information')),
              // ),

              // SliverGrid.builder(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 20,
              //     mainAxisSpacing: 20,
              //     childAspectRatio: 1,
              //   ),
              //   itemCount: 5,
              //   itemBuilder: (context, index) => Container(color: Colors.amber),
              // ),
            ],
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
