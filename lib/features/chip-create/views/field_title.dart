import 'package:flutter/material.dart';
import '/theme/theme.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MyColors.gray700),
    );
  }
}
