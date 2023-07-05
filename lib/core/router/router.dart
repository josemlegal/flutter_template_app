import 'package:flutter/material.dart';
import '../../presentation/views.dart';

class Router {
  static const loginView = '/login-view';
  static const homeView = '/home-view';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginView:
        return MaterialPageRoute(builder: (_) => LoginView());
      case homeView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => HomeView(
            currentUser: args['currentUser'],
          ),
        );
      default:
        return null;
    }
  }
}
