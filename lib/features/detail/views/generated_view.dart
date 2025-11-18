import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/pch.dart';

class GeneratedView extends StatelessWidget {
  const GeneratedView({super.key, required this.url, required this.onPressed});
  final String url;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, kSafeBot),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 335,
              height: 405,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.violet300, width: 12),
                borderRadius: BorderRadius.circular(35),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25 - 5),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: MyColors.white100),
                  errorWidget: (context, url, error) => Container(color: MyColors.white100),
                ),
              ),
            ),
          ),

          Spacer(),

          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: MyColors.orange400),
            onPressed: onPressed,
            child: Text(
              AppLocalizations.of(context)!.detail_generated_btn,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
