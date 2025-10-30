import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/network/network.dart';
import 'views/section_view.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Human')),
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: (context, child) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                sliver: SliverToBoxAdapter(child: SectionView(title: 'Add Image')),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                sliver: SliverToBoxAdapter(
                  child: UploadView(images: widget.vm.uploads, chooseAction: _chooseImage),
                ),
              ),

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

  void _chooseImage(int index, ImageSource source) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    // print('path:${file?.path}, name:${file?.name}, mime:${file?.mimeType}, length:${file?.length()}');
    final path = file?.path;
    if (path != null) {
      widget.vm.didChooseImage(index, path);
    }
  }
}
