import 'package:flutter/material.dart';
import 'package:ayumutekano/pages/home.dart';
import 'package:ayumutekano/pages/onboarding.dart';

class Routes {
  static const onBoarding = "/";
  static const home = "/home";
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: ((context) => const OnboardingScreen()),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
    }
  }
}
