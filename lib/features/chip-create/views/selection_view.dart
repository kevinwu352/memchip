import 'package:flutter/material.dart';
import '/theme/theme.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({
    super.key,
    required this.count,
    required this.per,
    required this.height,
    required this.spacing,
    this.normalColor = MyColors.violet300,
    this.selectedColor = MyColors.orange400,
    required this.itemBuilder,
    required this.selected,
    required this.selectAction,
  });

  final int count;
  final int per;
  final double height;
  final double spacing;
  final Color normalColor;
  final Color selectedColor;
  final Widget Function(int i) itemBuilder;
  final int? selected;
  final void Function(int i) selectAction;

  @override
  Widget build(BuildContext context) {
    int rows = (count / per).ceil();
    int cols = per;
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
                    child: GestureDetector(
                      onTap: () => selectAction(r * cols + c),
                      child: Container(
                        height: height,
                        decoration: BoxDecoration(
                          color: selected == (r * cols + c) ? selectedColor : normalColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: itemBuilder(r * cols + c),
                      ),
                    ),
                  )
                else
                  Container(),
            ],
          ),
      ],
    );
  }
}

class SelectionEntryView extends StatelessWidget {
  const SelectionEntryView({
    super.key,
    this.axis = Axis.horizontal,
    this.compact = false,
    this.spacing = 0,
    required this.lead,
    required this.trail,
  });

  final Axis axis;
  final bool compact;
  final double spacing;
  final Widget lead;
  final Widget trail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: axis == Axis.horizontal
          ? Row(
              mainAxisAlignment: compact ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
              spacing: spacing,
              children: [lead, trail],
            )
          : Column(
              mainAxisAlignment: compact ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
              spacing: spacing,
              children: [lead, trail],
            ),
    );
  }
}
