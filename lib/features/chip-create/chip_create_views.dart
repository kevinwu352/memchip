import 'package:flutter/material.dart';
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
  const UploadView({super.key, required this.images});
  final List<String?> images;
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
            ...images.map((e) => Image.asset(e ?? 'assets/images/create_addimg.png')),
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
