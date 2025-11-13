import 'package:flutter/material.dart';
import '/pch.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({super.key, required this.items, required this.selected, required this.onSelect});
  final List<String> items;
  final String selected;
  final void Function(String str) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MyColors.violet00,
      // decoration: ShapeDecoration(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      //   color: Colors.red,
      // ),
      padding: EdgeInsets.fromLTRB(36, 0, 36, kSafeBot + 10),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: ShapeDecoration(shape: StadiumBorder(), color: MyColors.violet100),
            margin: EdgeInsets.only(top: 10),
            width: 42,
            height: 6,
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                Text(
                  'Hobby',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: MyColors.gray700),
                ),
                Text(
                  'After selection, the corresponding holographic image will be displayed.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: MyColors.gray500),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ...items.map(
                  (e) => ActionChip(
                    shape: StadiumBorder(
                      side: BorderSide(color: selected == e ? MyColors.orange500 : MyColors.gray700, width: 2),
                    ),
                    backgroundColor: selected == e ? MyColors.orange400 : MyColors.white100,
                    label: Text(e),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: selected == e ? MyColors.white100 : MyColors.gray700,
                    ),
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => onSelect(e),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '2/3',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: MyColors.gray500),
            ),
          ),

          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: MyColors.orange400,
              padding: EdgeInsets.symmetric(horizontal: 70),
            ),
            onPressed: () {},
            child: Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
