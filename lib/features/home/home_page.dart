import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/storage/storage.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import '/utils/router.dart';
import '/models/user_model.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.vm});

  final HomeViewModel vm;

  HomePage.create({super.key, required Networkable network}) : vm = HomeViewModel(network: network);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: (context, child) {
          return SizedBox.expand(
            child: Column(
              children: [
                Selector<Defaults, UserModel?>(
                  selector: (_, object) => object.user,
                  builder: (context, value, child) =>
                      _HeaderView(avatarUrl: value?.avatarUrl, nickname: value?.nickname, phomail: value?.email),
                ),

                Selector<Secures, bool>(
                  selector: (_, object) => object.logined,
                  builder: (context, value, child) {
                    if (value) {
                      return Text('logined');
                    } else {
                      return Text('to login');
                    }
                  },
                ),
              ],
            ),
          );
        },
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
  const _HeaderView({this.avatarUrl, this.nickname, this.phomail});

  final String? avatarUrl;
  final String? nickname;
  final String? phomail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, kSafeTop + 30, 30, 30),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImage(
              // imageUrl: 'https://picsum.photos/200',
              // imageUrl: 'https://www.asdf1234.com/abcdef.jpg',
              // imageUrl: 'https://mock.httpstatus.io/200?delay=16000',
              imageUrl: avatarUrl ?? '',
              placeholder: (context, url) => Image.asset('assets/images/account_avatar.png'),
              errorWidget: (context, url, error) => Image.asset('assets/images/account_avatar.png'),
              width: 48,
              height: 48,
            ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      nickname ?? AppLocalizations.of(context)!.account_nickname_empty,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: MyColors.gray800),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => context.push(Routes.about),
                      icon: Image.asset('assets/images/account_more.png'),
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Image.asset('assets/images/account_phomail.png'),
                    SizedBox(width: 4),
                    Text(
                      phomail ?? AppLocalizations.of(context)!.account_phomail_empty,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.gray600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        Image.asset('assets/images/home_empty.png'),
        Text(
          AppLocalizations.of(context)!.home_empty_info,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: MyColors.violet100),
        ),
      ],
    );
  }
}
