import 'package:flutter/material.dart';
import '../../views.dart';

class Router {
  //Auth views
  static const landingView = '/landing-view';
  static const onboardingView = '/onboarding-view';
  static const forgotPasswordView = '/forgot-password-view';

  static const homeView = '/home-view';
  static const profileView = '/profile-view';
  static const tabsView = '/tabs-view';

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
      case profileView:
        return MaterialPageRoute(builder: (_) => const ProfileView());

      case onboardingView:
        return MaterialPageRoute(builder: (_) => const FormView());

      case tabsView:
        return MaterialPageRoute(builder: (_) => const TabsView());

      case forgotPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      default:
        return null;
    }
  }
}
