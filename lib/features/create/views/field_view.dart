import 'package:flutter/material.dart';
import '/theme/theme.dart';

class FieldView extends StatelessWidget {
  const FieldView({super.key, required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MyColors.gray700),
        ),
        child,
      ],
    );
  }
}
