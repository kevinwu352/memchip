import 'package:flutter/material.dart';
import '/pch.dart';
import 'cover_view.dart';
import 'action_view.dart';

class ActivatedView extends StatelessWidget {
  const ActivatedView({super.key, required this.url, required this.doing, required this.onPressed});
  final String url;
  final bool doing;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 60),
          child: CoverView(url: url),
        ),

        Spacer(),

        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, kSafeBot + 15),
          child: ActionView(
            info: AppLocalizations.of(context)!.detail_preview_info,
            button: AppLocalizations.of(context)!.detail_preview_btn,
            doing: doing,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
