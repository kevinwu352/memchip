import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/pch.dart';

class PreviewedView extends StatelessWidget {
  const PreviewedView({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
    required this.action,
  });
  final List<String> items;
  final List<int> selected;
  final void Function(int value) onSelect;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, kSafeBot),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 10),
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
                itemBuilder: (context, index) =>
                    _EntryView(url: items[index], selected: selected.contains(index), action: () => onSelect(index)),
              ),
            ),
          ),

          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: action,
            child: Text(
              AppLocalizations.of(context)!.detail_generate_btn,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({required this.url, required this.selected, required this.action});
  final String url;
  final bool selected;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35 + 2),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.white),
              errorWidget: (context, url, error) => Container(color: Colors.white),
            ),
          ),
          if (selected) Image.asset('assets/images/detail_check_mask.png', fit: BoxFit.fill),
        ],
      ),
    );
  }
}
