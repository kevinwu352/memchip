import 'package:flutter/material.dart';
import '/pch.dart';
import 'cover_view.dart';
import 'action_view.dart';

class ActivatedView extends StatelessWidget {
  const ActivatedView({super.key, required this.url, required this.action});
  final String url;
  final void Function() action;

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
            info: 'The colors the gradient should obtain at each of the stops.',
            title: 'Done',
            action: action,
          ),
        ),
      ],
    );
  }
}
