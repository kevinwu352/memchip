import 'package:flutter/material.dart';
import '/theme/theme.dart';

class CharView extends StatelessWidget {
  const CharView({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColors.violet00, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Wrap(spacing: 12, runSpacing: 10, children: children),
    );
  }
}

class CharEntryView extends StatelessWidget {
  const CharEntryView({super.key, required this.title, required this.selected, required this.action});

  final String title;
  final bool selected;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyColors.violet200, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      backgroundColor: selected ? MyColors.violet200 : MyColors.white100,
      label: Text(title),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: selected ? MyColors.white100 : MyColors.gray400,
      ),
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.symmetric(horizontal: 7),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: action,
    );
  }
}
