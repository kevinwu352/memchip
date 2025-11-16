import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/core/core.dart';

import '/ui/web_page.dart';

import '/features/splash/splash_page.dart';
import '/features/home/home_page.dart';
import '/features/login/login_page.dart';
import '/features/register/register_page.dart';
import '/features/about/about_page.dart';
import '/features/category/category_page.dart';
import '/features/create/create_human_page.dart';
import '/features/create/create_pet_page.dart';
import '/features/detail/detail_page.dart';

import '/models/box.dart';

abstract final class Routes {
  static String web(String url) => '/web/${url.encodeComponent}';

  static const splash = '/splash';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const about = '/about';
  static const category = '/category';
  static const createHuman = '/create-human';
  static const createPet = '/create-pet';
  static const detail = '/detail';
}

final RouteObserver<ModalRoute<void>> kRouteOb = RouteObserver<ModalRoute<void>>();

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  observers: [kRouteOb],
  routes: [
    GoRoute(
      path: '/web/:url',
      builder: (context, state) => WebPage(url: state.pathParameters['url']?.decodeComponent),
    ),

    GoRoute(path: Routes.splash, builder: (context, state) => SplashPage()),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomePage(network: context.read()),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) =>
          LoginPage(network: context.read(), secures: context.read(), defaults: context.read()),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => RegisterPage(network: context.read()),
    ),
    GoRoute(path: Routes.about, builder: (context, state) => AboutPage()),

    GoRoute(path: Routes.category, builder: (context, state) => CategoryPage()),
    GoRoute(
      path: Routes.createHuman,
      builder: (context, state) => CreateHumanPage(network: context.read()),
    ),
    GoRoute(
      path: Routes.createPet,
      builder: (context, state) => CreatePetPage(network: context.read()),
    ),
    GoRoute(
      path: Routes.detail,
      builder: (context, state) => DetailPage(box: GoRouterState.of(context).extra as Box, network: context.read()),
    ),
  ],
);
