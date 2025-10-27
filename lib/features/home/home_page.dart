import 'package:flutter/material.dart';
import 'package:memchip/theme/colors.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/core/core.dart';
import '/storage/storage.dart';
// import '/ui/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(top: kSafeTop),
            //   width: double.infinity,
            //   color: Colors.blue,
            //   child: Text('data'),
            // ),
            SizedBox(height: kSafeTop),

            _HeaderView(),

            Selector<Secures, bool>(
              selector: (_, object) => object.showLogin,
              builder: (context, value, child) {
                if (value) {
                  return Text('to login');
                } else {
                  return Text('show data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// return Expanded(child: MediaQuery.removePadding(removeTop: true, context: context, child: _HomeGridView()));
// class _HomeGridView extends StatelessWidget {
//   const _HomeGridView();
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 40,
//         childAspectRatio: 0.7,
//       ),
//       itemCount: 20,
//       itemBuilder: (context, index) => Container(color: Colors.red),
//     );
//   }
// }

class _HeaderView extends StatelessWidget {
  const _HeaderView({super.key, this.avatarUrl, this.nickname, this.email});

  final String? avatarUrl;
  final String? nickname;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          // imageUrl: 'https://picsum.photos/200',
          // imageUrl: 'https://www.asdf1234.com/abcdef.jpg',
          // imageUrl: 'https://mock.httpstatus.io/200?delay=16000',
          imageUrl: avatarUrl ?? '',
          placeholder: (context, url) => Image.asset('assets/images/account_avatar.png'),
          errorWidget: (context, url, error) => Image.asset('assets/images/account_avatar.png'),
          width: 48,
          height: 48,
        ),
        SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: MyColors.gray800),
            ),

            Row(
              children: [
                Image.asset('assets/images/account_phmail.png'),
                SizedBox(width: 4),
                Text(
                  'sub',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.gray600),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
