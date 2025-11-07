import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/storage/storage.dart';
import '/network/network.dart';
import '/theme/theme.dart';
import '/utils/router.dart';
import '/models/user.dart';
import '/models/box.dart';
import 'home_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.network});
  final Networkable network;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeVm vm = HomeVm(network: widget.network);

  @override
  void initState() {
    super.initState();
    vm.getAllChips();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    vm.updateNetwork(widget.network);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return SizedBox.expand(
            child: Column(
              children: [
                Selector<Defaults, User?>(
                  selector: (_, object) => object.user,
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.fromLTRB(30, kSafeTop + 30, 30, 30),
                    child: _HeaderView(avatarUrl: value?.avatarUrl, nickname: value?.nickname, phomail: value?.email),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.home_section_title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.gray800),
                  ),
                ),

                if (vm.boxes.isEmpty)
                  Expanded(
                    child: Padding(padding: const EdgeInsets.only(top: 50), child: _EmptyView()),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 139 / 247,
                      ),
                      itemCount: vm.boxes.length,
                      itemBuilder: (context, index) => _EntryView(box: vm.boxes[index]),
                    ),
                  ),

                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, kSafeBot + 24),
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: MyColors.violet300,
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () => context.push(context.read<Secures>().logined ? Routes.category : Routes.login),
                    label: Text(AppLocalizations.of(context)!.home_new_btn),
                    icon: Image.asset('assets/images/home_new.png'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({this.avatarUrl, this.nickname, this.phomail});

  final String? avatarUrl;
  final String? nickname;
  final String? phomail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CachedNetworkImage(
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
                  Expanded(
                    child: Text(
                      nickname ?? AppLocalizations.of(context)!.account_nickname_empty,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: MyColors.gray800),
                    ),
                  ),
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
                  Expanded(
                    child: Text(
                      phomail ?? AppLocalizations.of(context)!.account_phomail_empty,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: MyColors.gray600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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

class _EntryView extends StatelessWidget {
  const _EntryView({required this.box});

  final Box box;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: box.coverImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.white),
              errorWidget: (context, url, error) => Container(color: Colors.white),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Image.asset('assets/images/home_entry_paw.png'),
                    Expanded(
                      child: Text(
                        box.boxName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColors.gray700),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Image.asset('assets/images/home_entry_time.png'),
                    Expanded(
                      child: Text(
                        GetTimeAgo.parse(box.createdTime, locale: AppLocalizations.of(context)!.localeName),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MyColors.gray500),
                      ),
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
