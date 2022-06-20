import 'package:film_fan/pages/detailPage.dart';
import 'package:film_fan/pages/favoritesPage.dart';
import 'package:flutter/material.dart';
import 'package:film_fan/pages/home.dart';

class Routes {
  static const home = "/";
  static const detail = "/detail";
  static const favorites = "/favorites";
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      case Routes.favorites:
        return MaterialPageRoute(
          builder: ((context) => const FavoritesPage()),
        );
      case Routes.detail:
        final DetailPage args = settings.arguments as DetailPage;
        return MaterialPageRoute(
          builder: (context) {
            return DetailPage(
              movieId: args.movieId,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
    }
  }
}
