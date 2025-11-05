import 'package:flutter/material.dart';
import '/theme/theme.dart';

class SectionView extends StatelessWidget {
  const SectionView({super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: MyColors.gray700),
            ),
          ),
          Column(spacing: 12, crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ],
      ),
    );
  }
}
