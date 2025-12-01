// import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pch.dart';
import 'utils/video_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true;

  await pathInit();

  final secures = Secures();
  await secures.init();

  final defaults = Defaults();
  await defaults.init();

  final vdown = VideoDownloader();
  await vdown.init();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => EventBus()),
        ChangeNotifierProvider.value(value: secures),
        ChangeNotifierProvider.value(value: defaults),
        ProxyProvider<Secures, Networkable>(
          create: (context) => HttpClient.token(context.read<Secures>().accessToken),
          update: (context, value, previous) =>
              (previous is HttpClient) ? (previous..token = value.accessToken) : HttpClient.token(value.accessToken),
          // update: (context, value, previous) => HttpClient.token(value.accessToken),
        ),
        ChangeNotifierProvider.value(value: vdown),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initScreenMetrics(context);

    final language = context.select((Defaults v) => v.language);
    // final theme = context.select((Defaults v) => v.theme);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.white100,
        appBarTheme: AppBarThemeData(
          backgroundColor: MyColors.violet300,
          foregroundColor: MyColors.white100,
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      // theme: ThemeData(colorScheme: MySchemes.light),
      // darkTheme: ThemeData(colorScheme: MySchemes.dark),
      // themeMode: theme,
      routerConfig: router(),
    );
  }
}
