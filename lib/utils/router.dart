import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/core/core.dart';

import '/ui/web_page.dart';

import '/features/home/home_page.dart';
import '/features/login/login_page.dart';
import '/features/about/about_page.dart';
import '/features/chip-create/chip_category_page.dart';
import '/features/chip-create/chip_create_human_page.dart';
import '/features/chip-create/chip_create_pet_page.dart';

abstract final class Routes {
  static String web(String url) => '/web/${url.encodeComponent}';

  static const home = '/home';
  static const login = '/login';
  static const about = '/about';
  static const chipCategory = '/chip-category';
  static const chipCreateHuman = '/chip-create-human';
  static const chipCreatePet = '/chip-create-pet';
}

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: '/web/:url',
      builder: (context, state) => WebPage(url: state.pathParameters['url']?.decodeComponent),
    ),

    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomePage.create(network: context.read()),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) =>
          LoginPage.create(network: context.read(), secures: context.read(), defaults: context.read()),
    ),
    GoRoute(path: Routes.about, builder: (context, state) => AboutPage()),

    GoRoute(path: Routes.chipCategory, builder: (context, state) => ChipCategoryPage()),
    GoRoute(
      path: Routes.chipCreateHuman,
      builder: (context, state) => ChipCreateHumanPage.create(network: context.read()),
    ),
    GoRoute(path: Routes.chipCreatePet, builder: (context, state) => ChipCreatePetPage()),
  ],
);
