import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template_app/application/services/shared_preferences_service.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/mixins/validation_mixin.dart';
import 'package:flutter_template_app/core/router/router.dart' as router;
import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/user/domain/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../user/domain/models/user_model.dart';

class OnboardingViewController extends ChangeNotifier with Validation {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final NavigationService _navigationService;
  final SharedPreferenceApi _sharedPreferences;
  final PageController pageController = PageController();
  final FocusNode nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  OnboardingViewController({
    AuthRepository? authRepository,
    NavigationService? navigationService,
    SharedPreferenceApi? sharedPreferences,
    UserRepository? userRepository,
  })  : _authRepository = authRepository ?? locator(),
        _sharedPreferences = sharedPreferences ?? locator(),
        _navigationService = navigationService ?? locator(),
        _userRepository = userRepository ?? locator();

  String _name = '';
  String _nameValidationMessage = '';

  String get name => _name;
  String get nameValidationMessage => _nameValidationMessage;

  void onFormInit() {
    if (!isEmptyOrNull(_sharedPreferences.getUserName())) {
      _name = _sharedPreferences.getUserName()!;
      _nameValidationMessage = validateName(_name);
      notifyListeners();
    }
  }

  void updateName(String value) {
    _name = value;
    _nameValidationMessage = validateName(_name);
    notifyListeners();
  }

  bool validateInfoForm() {
    _nameValidationMessage = validateName(name);

    if (_nameValidationMessage.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> submitForm() async {
    bool canSubmit = validateInfoForm();

    log(_name);

    if (!canSubmit) {
      log('no puedo submit');
      notifyListeners();
      return;
    }

    final newUserModel = User(
      name: name,
      email: _authRepository.userEmail!,
      firebaseId: _authRepository.userId,
    );

    log(newUserModel.toJson().toString());
    await _userRepository.createNewUser(newUserModel);

    await _navigationService.navigateTo(router.Router.tabsView);
  }
}

final onboardingViewProvider = ChangeNotifierProvider<OnboardingViewController>(
  (ref) {
    return OnboardingViewController(
      navigationService: locator<NavigationService>(),
      authRepository: locator<AuthRepository>(),
      sharedPreferences: locator<SharedPreferenceApi>(),
    );
  },
);
