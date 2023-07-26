// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_template_app/auth/domain/use_cases/sign_in_with_email_and_pass.dart';
import 'package:flutter_template_app/auth/domain/use_cases/sign_in_with_oauth.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/core/mixins/validation_mixin.dart';
import 'package:flutter_template_app/core/router/router.dart' as router;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

enum SocialSignIn {
  GoogleSignIn,
  AppleSignIn,
}

enum SignIn {
  Login,
  Signup,
}

class LandingViewController extends ChangeNotifier with Validation {
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;

  LandingViewController({
    required NavigationService navigationService,
    required SnackbarService snackbarService,
  })  : _navigationService = navigationService,
        _snackbarService = snackbarService;

  //Flags
  bool isLoading = false;

  String _email = '';
  String _emailValidationMessage = '';
  String _password = '';
  String _passwordValidationMessage = '';
  String _confirmPassword = '';
  String _confirmPasswordValidationMessage = '';

  String get email => _email;
  String get emailValidationMessage => _emailValidationMessage;
  String get password => _password;
  String get passwordValidationMessage => _passwordValidationMessage;
  String get confirmPassword => _confirmPassword;
  String get confirmPasswordValidationMessage =>
      _confirmPasswordValidationMessage;

  Future<void> submitLoginForm({required SignIn signInType}) async {
    _emailValidationMessage = validateEmail(_email);
    _passwordValidationMessage = validatePassword(_password);
    _confirmPasswordValidationMessage =
        validateConfirmPassword(_password, _confirmPassword);

    if (_emailValidationMessage.isNotEmpty ||
        _passwordValidationMessage.isNotEmpty) {
      notifyListeners();
      return;
    }
    if (signInType == SignIn.Signup &&
        _confirmPasswordValidationMessage.isNotEmpty) {
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();
    try {
      final userExists = await signInWithEmailAndPasswordUseCase.call(
          signInType: signInType, email: email, password: password);

      if (!userExists) {
        _navigationService.clearStackAndShow(router.Router.onboardingView);
      } else {
        _navigationService.clearStackAndShow(router.Router.tabsView);
      }
      isLoading = false;
      notifyListeners();
    } on CustomError catch (e) {
      isLoading = false;
      notifyListeners();
      _snackbarService.showSnackbar(message: e.message);
    }
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  Future<void> signinWithOAuth(SocialSignIn signInType) async {
    isLoading = true;
    notifyListeners();
    try {
      final userHasRegisteredBefore =
          await signInWithOAuthUseCase.call(signInType: signInType);
      if (!userHasRegisteredBefore) {
        _navigationService.clearStackAndShow(router.Router.onboardingView);
        isLoading = false;
      } else {
        _navigationService.clearStackAndShow(router.Router.tabsView);
        isLoading = false;
      }
      notifyListeners();
    } on CustomError catch (e) {
      isLoading = false;
      _snackbarService.showSnackbar(message: e.message);
    }
  }

  void navigateToForgotPassword() {
    _navigationService.navigateTo('/forgot-password-view');
  }
}

final landingViewControllerProvider =
    ChangeNotifierProvider<LandingViewController>(
  (ref) {
    return LandingViewController(
      navigationService: locator<NavigationService>(),
      snackbarService: locator<SnackbarService>(),
    );
  },
);
