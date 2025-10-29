import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/storage/storage.dart';
import '/theme/theme.dart';
import '/utils/router.dart';

enum _Kind {
  license,
  term,
  privacy;

  factory _Kind.fromIndex(int i) => _Kind.values[i];

  String title(BuildContext context) {
    switch (this) {
      case license:
        return AppLocalizations.of(context)!.about_line_license_title;
      case term:
        return AppLocalizations.of(context)!.about_line_term_title;
      case privacy:
        return AppLocalizations.of(context)!.about_line_privacy_title;
    }
  }

  String get url {
    switch (this) {
      case license:
        return 'https://www.baidu.com';
      case term:
        return 'https://www.qq.com';
      case privacy:
        return 'https://www.bing.com';
    }
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.about_page_title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _Kind.values.length,
              separatorBuilder: (context, index) => Divider(height: 1, thickness: 1, indent: 30, endIndent: 30),
              itemBuilder: (context, index) => ListTile(
                title: Text(_Kind.fromIndex(index).title(context)),
                titleTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray600),
                trailing: Icon(Icons.adaptive.arrow_forward, size: 14),
                iconColor: MyColors.gray300,
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                onTap: () => context.push(Routes.web(_Kind.fromIndex(index).url)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, kSafeBot),
            child: Column(
              children: [
                if (context.read<Secures>().logined)
                  Container(
                    padding: EdgeInsets.only(bottom: 40),
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: MyColors.violet300,
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        final secures = context.read<Secures>();
                        secures.lastUsername = null;
                        secures.accessToken = null;
                        final defaults = context.read<Defaults>();
                        defaults.user = null;
                        context.pop();
                      },
                      child: Text(AppLocalizations.of(context)!.about_logout_btn),
                    ),
                  ),

                Container(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    AppLocalizations.of(context)!.about_version(kCurrentAppVersion),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColors.gray500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
