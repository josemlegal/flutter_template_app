import 'package:flutter/material.dart';
import '../../presentation/views.dart';

class Router {
  static const landingView = '/landing-view';
  static const homeView = '/home-view';
  static const randomView = '/random-view';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingView:
        return MaterialPageRoute(builder: (_) => const LandingView());
      case homeView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => HomeView(
            currentUser: args['currentUser'],
          ),
        );
      case randomView:
        return MaterialPageRoute(builder: (_) => const RandomView());

      default:
        return null;
    }
  }
}
