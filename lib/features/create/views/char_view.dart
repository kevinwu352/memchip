import 'package:flutter/material.dart';
import '/pch.dart';

class CharView extends StatelessWidget {
  const CharView({super.key, required this.items, this.selected, required this.onSelected});
  final List<String> items;
  final int? selected;
  final void Function(int value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColors.violet00, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        children: [
          ...items.indexed.map(
            (e) => ActionChip(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: MyColors.violet200, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: e.$1 == selected ? MyColors.violet200 : MyColors.white100,
              label: Text(e.$2),
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: e.$1 == selected ? MyColors.white100 : MyColors.gray400,
              ),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.symmetric(horizontal: 7),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              onPressed: () => onSelected(e.$1),
            ),
          ),
        ],
      ),
    );
  }
}
