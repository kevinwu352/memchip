import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/pch.dart';

class PreviewedView extends StatelessWidget {
  const PreviewedView({super.key, required this.action});
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
                  'Select Image',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.gray800),
                ),
                Text(
                  // 'Please choose one',
                  'Please choose one image from the following to create a holographic projection.',
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
                itemCount: 7,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) => _EntryView(url: '', selected: index == 2, action: action),
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: () {},
            child: Text('Confirm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _EntryView extends StatelessWidget {
  const _EntryView({super.key, required this.url, required this.selected, required this.action});
  final String url;
  final bool selected;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 150,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
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
                        errorWidget: (context, url, error) => Container(color: Colors.red),
                      ),
                    ),
                    if (selected) Image.asset('assets/images/detail_check_mask.png', fit: BoxFit.fill),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: action,
                child: Image.asset(
                  selected ? 'assets/images/detail_check_on.png' : 'assets/images/detail_check_off.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
