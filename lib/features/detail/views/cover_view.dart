import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoverView extends StatelessWidget {
  const CoverView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 321,
      height: 387,
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
    );
  }
}
