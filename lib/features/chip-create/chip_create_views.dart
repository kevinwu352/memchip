import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/theme/theme.dart';

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
  const UploadView({super.key, required this.images, required this.imageChanged});
  final List<String?> images;
  final void Function(int index, String? path) imageChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          spacing: 8,
          children: [
            //
            ...images.indexed.map(
              (e) => GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final file = await picker.pickImage(source: ImageSource.gallery);
                  // print('path:${file?.path}, name:${file?.name}, mime:${file?.mimeType}, length:${file?.length()}');
                  final path = file?.path;
                  if (path != null) {
                    imageChanged(e.$1, path);
                  }
                },
                child: e.$2 is String
                    ? Image.file(width: 93, height: 108, File(e.$2!), fit: BoxFit.cover)
                    : Image.asset(width: 93, height: 108, 'assets/images/create_addimg.png'),
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
}
