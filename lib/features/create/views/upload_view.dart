import 'dart:io';
import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import '/pch.dart';
import '/utils/image_uploader.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key, required this.images, required this.imageChoosed, required this.info});
  final List<ImageUploader> images;
  final void Function(int index, String path) imageChoosed;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          spacing: 8,
          children: [
            ...images.indexed.map(
              (e) => DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(3),
                  padding: EdgeInsets.all(1),
                  color: MyColors.violet200,
                  dashPattern: [3, 3],
                ),
                child: GestureDetector(
                  onTap: e.$2.uploading ? null : () => _showImageSources(e.$1, context),
                  child: Container(
                    width: 91,
                    height: 106,
                    color: MyColors.violet00,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/images/create_add.png'),
                        if (e.$2.path != null)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Image.file(File(e.$2.path!), fit: BoxFit.cover),
                            ),
                          ),
                        if (e.$2.uploading) CircularProgressIndicator.adaptive(backgroundColor: MyColors.white100),
                        // if (e.$2.success != null) Text(e.$2.success == true ? 'success' : 'failed'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          info,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MyColors.gray500),
        ),
      ],
    );
  }

  void _showImageSources(int index, BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      actions: [
        BottomSheetAction(
          title: Text(AppLocalizations.of(context)!.create_image_library),
          onPressed: (context) => _chooseImage(index, ImageSource.gallery, context),
        ),
        BottomSheetAction(
          title: Text(AppLocalizations.of(context)!.create_image_camera),
          onPressed: (context) => _chooseImage(index, ImageSource.camera, context),
        ),
      ],
      cancelAction: CancelAction(title: Text(AppLocalizations.of(context)!.cancel)),
    );
  }

  void _chooseImage(int index, ImageSource source, BuildContext context) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    // print('path:${file?.path}, name:${file?.name}, mime:${file?.mimeType}, length:${file?.length()}');
    final path = file?.path;
    if (path != null && path.isNotEmpty) {
      imageChoosed(index, path);
    }
  }
}
