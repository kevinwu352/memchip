import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/core/core.dart';

import 'web_page.dart';

import '/features/home/home_page.dart';
import '/features/login/login_page.dart';
import '/features/about/about_page.dart';

abstract final class Routes {
  static String web(String url) => '/web/${url.encodeComponent}';

  static const home = '/home';
  static const login = '/login';
  static const about = '/about';
}

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: '/web/:url',
      builder: (context, state) => WebPage(url: state.pathParameters['url']?.decodeComponent),
    ),

    GoRoute(path: Routes.home, builder: (context, state) => HomePage()),
    GoRoute(
      path: Routes.login,
      builder: (context, state) =>
          LoginPage.create(network: context.read(), secures: context.read(), defaults: context.read()),
    ),
    GoRoute(path: Routes.about, builder: (context, state) => AboutPage()),
  ],
);
