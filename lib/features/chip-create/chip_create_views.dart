import 'dart:io';
import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import '/l10n/localizations.dart';
import '/theme/theme.dart';
import 'chip_create_human_view_model.dart';

class SectionView extends StatelessWidget {
  const SectionView({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: MyColors.gray700),
    );
  }
}

class UploadView extends StatelessWidget {
  const UploadView({super.key, required this.images, required this.chooseAction});
  final List<UploadImage> images;
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
            // ...images.indexed.map(
            //   (e) => GestureDetector(
            //     onTap: () => _showImageSources(e.$1, context),
            //     child: e.$2.path is String
            //         ? Image.file(width: 93, height: 108, File(e.$2.path!), fit: BoxFit.cover)
            //         : Image.asset(width: 93, height: 108, 'assets/images/create_addimg.png'),
            //   ),
            // ),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(3),
                padding: EdgeInsets.all(1),
                color: MyColors.violet200,
                dashPattern: [3, 3],
              ),
              child: Container(
                width: 91,
                height: 106,
                color: MyColors.violet00,
                foregroundDecoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/create_add.png')),
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
