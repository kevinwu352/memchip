import 'package:flutter/material.dart';
import '/theme/theme.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({
    super.key,
    required this.count,
    required this.itemsPerRow,
    required this.height,
    required this.spacing,
  });

  final int count;
  final int itemsPerRow;
  final double height;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    int rows = (count / itemsPerRow).ceil();
    int cols = itemsPerRow;
    double pad = spacing / 2;
    return Table(
      children: [
        for (var r = 0; r < rows; ++r)
          TableRow(
            children: [
              for (var c = 0; c < cols; ++c)
                if (r * cols + c < count)
                  Padding(
                    padding: EdgeInsets.only(
                      left: c != 0 ? pad : 0,
                      right: c != cols - 1 ? pad : 0,
                      top: r != 0 ? pad : 0,
                      bottom: r != rows - 1 ? pad : 0,
                    ),
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(color: MyColors.violet300, borderRadius: BorderRadius.circular(8)),
                      child: Text('$r $c'),
                    ),
                  )
                else
                  Container(),
            ],
          ),

        // final v = c * per + r;
        // if (c * per + r < count) {
        //   print('$c $r $v');
        // } else {
        //   print('$c $r $v xxx');
        // }
        // TableRow(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(right: 4),
        //       child: Container(
        //         height: 60,
        //         decoration: BoxDecoration(color: MyColors.violet300, borderRadius: BorderRadius.circular(8)),
        //         child: Text('a'),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(left: 4),
        //       child: Container(
        //         height: 60,
        //         decoration: BoxDecoration(color: MyColors.violet300, borderRadius: BorderRadius.circular(8)),
        //         child: Text('111'),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
