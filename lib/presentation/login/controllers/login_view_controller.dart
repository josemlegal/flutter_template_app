import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/data/user/repositories/user_repository_implementation.dart';
import 'package:flutter_template_app/domain/user/models/user_model.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewController extends ChangeNotifier {
  final UserRepository _userRepository;
  final NavigationService _navigationService;

  LoginViewController({
    required NavigationService navigationService,
    required UserRepository userRepository,
  })  : _navigationService = navigationService,
        _userRepository = userRepository;

  Future<void> getCurrentUser() async {
    try {
      final currentUser = await _userRepository.getUser();
      log(currentUser.toString());
      goToHomeView(currentUser);
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

  void goToHomeView(User currentUser) {
    _navigationService.pushNamedAndRemoveUntil('/home-view', arguments: {
      'currentUser': currentUser,
    });
  }
}

final loginViewProvider = ChangeNotifierProvider(
  (ref) => LoginViewController(
    navigationService: locator<NavigationService>(),
    userRepository: locator<UserRepositoryImplementation>(),
  ),
);
