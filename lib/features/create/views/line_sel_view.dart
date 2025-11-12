import 'package:flutter/material.dart';
import '/pch.dart';

class LineSelView extends StatelessWidget {
  const LineSelView({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
  }
}

class LineSelEntryView extends StatelessWidget {
  const LineSelEntryView({
    super.key,
    required this.icon,
    required this.name,
    required this.selected,
    required this.action,
  });

  final String icon;
  final String name;
  final bool selected;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: MyColors.violet100, width: 1)),
          color: selected ? MyColors.violet100 : null,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          spacing: 8,
          children: [
            Image.asset(
              icon,
              width: 16,
              height: 16,
              color: Colors.white,
              colorBlendMode: selected ? BlendMode.srcIn : BlendMode.dst,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MyColors.gray700),
            ),
          ],
        ),
      ),
    );
  }
}
