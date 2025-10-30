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
