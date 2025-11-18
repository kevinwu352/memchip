import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/pch.dart';

class PreviewedView extends StatelessWidget {
  const PreviewedView({
    super.key,
    required this.items,
    this.selected,
    this.onSelected,
    required this.generating,
    this.onPressed,
  });
  final List<String> items;
  final int? selected;
  final void Function(int value)? onSelected;
  final bool generating;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, kSafeBot),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.detail_generate_title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.gray800),
                ),
                Text(
                  AppLocalizations.of(context)!.detail_generate_info,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: MyColors.gray500),
                ),
              ],
            ),
          ),

          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) => _EntryView(
                  url: items[index],
                  selected: selected == index,
                  onSelected: () => generating ? null : onSelected?.call(index),
                ),
              ),
            ),
          ),

          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: generating ? null : onPressed,
            child: Text(
              generating
                  ? AppLocalizations.of(context)!.detail_generate_btn_ing
                  : AppLocalizations.of(context)!.detail_generate_btn,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({required this.url, required this.selected, required this.onSelected});
  final String url;
  final bool selected;
  final void Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35 + 2),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: MyColors.white100),
              errorWidget: (context, url, error) => Container(color: MyColors.white100),
            ),
          ),
          if (selected) Image.asset('assets/images/detail_check_mask.png', fit: BoxFit.fill),
        ],
      ),
    );
  }
}
