import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';
import '/core/core.dart';
import '/storage/storage.dart';
import '/theme/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.about_page_title)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(title: Text(AppLocalizations.of(context)!.about_line_license_title)),
                Divider(),
                ListTile(title: Text(AppLocalizations.of(context)!.about_line_term_title)),
                Divider(),
                ListTile(title: Text(AppLocalizations.of(context)!.about_line_privacy_title)),
              ],
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
                      onPressed: () {},
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
