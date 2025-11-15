import 'package:flutter/material.dart';
import '/pch.dart';

class SectionView extends StatelessWidget {
  const SectionView({super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: MyColors.gray700),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 12, children: children),
        ],
      ),
    );
  }
}
