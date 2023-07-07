import 'package:flutter/material.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:stacked_services/stacked_services.dart';

enum SocialSignIn {
  GoogleSignIn,
  AppleSignIn,
}

enum SignIn {
  Login,
  Signup,
}

class LandingViewController extends ChangeNotifier {
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;
  // final AuthService _authService;

  LandingViewController({
    NavigationService? navigationService,
    SnackbarService? snackbarService,
    // AuthService? authService,
  })  : _navigationService = navigationService ?? locator<NavigationService>(),
        _snackbarService = snackbarService ?? locator<SnackbarService>();
  // _authService = authService ?? locator<AuthService>();
}
