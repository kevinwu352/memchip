import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';

import '/core/core.dart';
import '/storage/storage.dart';
import '/network/network.dart';
// import '/theme/theme.dart';
import '/ui/router.dart';
import '/utils/download_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await pathInit();

  final secures = Secures();
  await secures.load();

  final defaults = Defaults();
  await defaults.init();
  await defaults.load();

  final downmg = DownloadManager();
  await downmg.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: secures),
        ChangeNotifierProvider.value(value: defaults),
        ProxyProvider<Secures, Networkable>(
          create: (context) => HttpClient.token(context.read<Secures>().accessToken),
          update: (context, value, previous) =>
              (previous is HttpClient) ? (previous..setToken(value.accessToken)) : HttpClient.token(value.accessToken),
        ),
        ChangeNotifierProvider.value(value: downmg),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initSafeMetrics(MediaQuery.viewPaddingOf(context));

    final language = context.select((Defaults v) => v.language);
    // final theme = context.select((Defaults v) => v.theme);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      // theme: ThemeData(colorScheme: MySchemes.light),
      // darkTheme: ThemeData(colorScheme: MySchemes.dark),
      // themeMode: theme,
      routerConfig: router(),
    );
  }
}
