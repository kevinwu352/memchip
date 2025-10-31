import 'dart:io';
import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import '/l10n/localizations.dart';
import '/theme/theme.dart';
import '../chip_create_human_view_model.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key, required this.images, required this.chooseAction});
  final List<ImageUploader> images;
  final void Function(int index, ImageSource source) chooseAction;

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
                        if (e.$2.uploading) CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
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
          'Please upload one clear front photo and one side photo of your pet.',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
        ),
      ],
    );
  }

  void _showImageSources(int index, BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      actions: [
        BottomSheetAction(
          title: Text(AppLocalizations.of(context)!.chip_create_image_library),
          onPressed: (context) => chooseAction(index, ImageSource.gallery),
        ),
        BottomSheetAction(
          title: Text(AppLocalizations.of(context)!.chip_create_image_camera),
          onPressed: (context) => chooseAction(index, ImageSource.camera),
        ),
      ],
      cancelAction: CancelAction(title: Text(AppLocalizations.of(context)!.cancel)),
    );
  }
}
