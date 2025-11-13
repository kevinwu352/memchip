import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/pch.dart';
import 'action_view.dart';

class UnknownView extends StatelessWidget {
  const UnknownView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 60),
          width: 321,
          height: 387 + 60,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.white),
                  errorWidget: (context, url, error) => Container(color: Colors.white),
                ),
              ),
              Image.asset('assets/images/detail_cover_frame.png'),
            ],
          ),
        ),

        Spacer(),

        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, kSafeBot + 15),
          child: ActionView(
            info: 'The colors the gradient should obtain at each of the stops.',
            // info: 'abc',
            title: 'Done',
            action: () {},
          ),
        ),
      ],
    );
  }
}
