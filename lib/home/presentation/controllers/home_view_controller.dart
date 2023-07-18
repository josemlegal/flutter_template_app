import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/user/domain/models/user_model.dart';
import 'package:flutter_template_app/user/domain/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewController extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;

  // States
  final User? _currentUser = null;
  bool _isResendingEmailLink = false;
  bool isLoading = false;

  // Getters
  User get currentUser => _currentUser!;

  HomeViewController({
    required NavigationService navigationService,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required SnackbarService snackbarService,
  })  : _navigationService = navigationService,
        _userRepository = userRepository,
        _authRepository = authRepository,
        _snackbarService = snackbarService;

  bool get isResendingEmailLink => _isResendingEmailLink;

  Future<void> getCurrentUser() async {
    try {
      await _userRepository.getUser(_userRepository.userId!);
      goToHomeView();
    } catch (err) {
      print(err);
    }
  }

  String? textInputEmptyValidator(value) {
    if (value!.isEmpty) {
      return 'El campo esta vacio';
    } else {
      return null;
    }
  }

  void goToHomeView() {
    _navigationService.pushNamedAndRemoveUntil('/home-view');
  }

  // example logout
  void onLogOut() async {
    await _authRepository.logout();
    _navigationService.clearStackAndShow('/landing-view');
  }

  // example verify email

  Future<void> checkEmailVerification() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    try {
      final isEmailVerified = await _authRepository.checkEmailVerification();
      log('isEmailVerified: $isEmailVerified');
      if (!isEmailVerified) {
        _snackbarService.showSnackbar(
          message: 'Todavia no has verificado tu correo, intenta de nuevo',
        );
        isLoading = false;
        notifyListeners();
        return;
      } else {
        _snackbarService.showSnackbar(
          message: 'Ya estas verificado',
        );
        isLoading = false;
        notifyListeners();
      }

      // _navigationService.clearStackAndShow(Routes.tabsView);
    } on CustomError catch (e) {
      _snackbarService.showSnackbar(message: e.message);
      isLoading = false;
    }
  }

  void setIsResendingEmailLink(bool value) {
    _isResendingEmailLink = value;
    notifyListeners();
  }

  Future<void> sendEmailLink() async {
    setIsResendingEmailLink(true);
    try {
      await _authRepository.sendEmailVerificationLink();
      _snackbarService.showSnackbar(
        message: 'Se ha reenviado el link de verificacion',
      );
    } on CustomError catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } finally {
      setIsResendingEmailLink(false);
    }
  }
}

final homeViewProvider = ChangeNotifierProvider(
  (ref) => HomeViewController(
    navigationService: locator<NavigationService>(),
    authRepository: locator<AuthRepository>(),
    userRepository: locator<UserRepository>(),
    snackbarService: locator<SnackbarService>(),
  ),
);
