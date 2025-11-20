import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '/pch.dart';
import 'home_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.network, required this.defaults});
  final Networkable network;
  final Defaults defaults;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver, RouteAware {
  late final vm = HomeVm(network: widget.network, defaults: widget.defaults);

  @override
  void initState() {
    super.initState();
    vm.updateUser();
    vm.loadChips();
    _subscribeBoxesChange();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    kRouteOb.subscribe(this, ModalRoute.of(context)!);
    _loadLocale();
  }

  @override
  void dispose() {
    _boxesSub?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    kRouteOb.unsubscribe(this);
    super.dispose();
  }

  StreamSubscription? _boxesSub;
  void _subscribeBoxesChange() {
    _boxesSub = context.read<EventBus>().listen(
      type: [
        EventType.accountLogin,
        EventType.accountLogout,
        EventType.boxCreated,
        EventType.boxDeleted,
        EventType.boxUpdated,
      ],
      onEvent: (event) => vm.loadChips(force: true),
    );
  }

  void _loadLocale() {
    if (widget.network is HttpClient) {
      final name = AppLocalizations.of(context)?.localeName;
      (widget.network as HttpClient).local = name?.startsWith('zh') == true ? 'zh' : 'en';
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('app-state: ${state.name}');
    if (state == AppLifecycleState.resumed) {
      vm.updateUser();
      vm.loadChips();
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    print('route: did appear');
    vm.appeared = true;
    vm.loadChips();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    print('route: did disappear');
    vm.appeared = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) => SizedBox.expand(
          child: Column(
            children: [
              Selector<Defaults, User?>(
                selector: (_, object) => object.user,
                builder: (context, value, child) => Padding(
                  padding: EdgeInsets.fromLTRB(30, kSafeTop + 30, 30, 30),
                  child: _HeaderView(avatarUrl: value?.avatarUrl, nickname: value?.nickname, phomail: value?.account),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.home_section_title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.gray800),
                ),
              ),

              Expanded(
                child: vm.boxes.isNotEmpty
                    ? GridView.builder(
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 139 / 247,
                        ),
                        itemCount: vm.boxes.length,
                        itemBuilder: (context, index) => _EntryView(
                          box: vm.boxes[index],
                          onTap: () => context.push(Routes.detail, extra: vm.boxes[index]),
                        ),
                      )
                    : vm.loading
                    ? CircularProgressIndicator.adaptive()
                    : Padding(padding: EdgeInsets.only(top: 50), child: _EmptyView()),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, kSafeBot + 24),
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: MyColors.violet300),
                  onPressed: () => context.push(context.read<Secures>().logined ? Routes.category : Routes.login),
                  label: Text(
                    AppLocalizations.of(context)!.home_new_btn,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  icon: Image.asset('assets/images/home_new.png'),
                ),
              ),
            ],
          ),
        ),
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
          child: avatarUrl != null
              ? CachedNetworkImage(
                  imageUrl: avatarUrl ?? '',
                  placeholder: (context, url) => Image.asset('assets/images/home_avatar.png'),
                  errorWidget: (context, url, error) => Image.asset('assets/images/home_avatar.png'),
                  width: 48,
                  height: 48,
                )
              : Image.asset('assets/images/home_avatar.png', width: 48, height: 48),
        ),

        SizedBox(width: 12),

        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      nickname ?? AppLocalizations.of(context)!.home_nickname_empty,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: MyColors.gray800),
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push(Routes.about),
                    icon: Image.asset('assets/images/home_more.png'),
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
                  Image.asset('assets/images/home_phomail.png'),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      phomail ?? AppLocalizations.of(context)!.home_phomail_empty,
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
  const _EntryView({required this.box, required this.onTap});
  final Box box;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: MyColors.white100,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: box.coverImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: MyColors.white100),
                errorWidget: (context, url, error) => Container(color: MyColors.white100),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Image.asset('assets/images/home_entry_paw.png'),
                      Expanded(
                        child: Text(
                          box.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColors.gray700),
                        ),
                      ),
                      if (box.status == BoxStatus.generating || box.status == BoxStatus.generated)
                        Container(
                          width: 33,
                          height: 17,
                          decoration: ShapeDecoration(
                            shape: StadiumBorder(),
                            color: box.status == BoxStatus.generating ? MyColors.violet50 : MyColors.green,
                          ),
                          child: box.status == BoxStatus.generating
                              ? Image.asset('assets/images/home_entry_doing.png')
                              : Image.asset('assets/images/home_entry_done.png'),
                        ),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Image.asset('assets/images/home_entry_time.png'),
                      Expanded(
                        child: Text(
                          GetTimeAgo.parse(
                            box.createdTime,
                            locale: AppLocalizations.of(context)?.localeName.startsWith('zh') == true ? 'zh' : 'en',
                          ),
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
      ),
    );
  }
}
