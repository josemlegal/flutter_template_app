import 'package:flutter/foundation.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/data/user/repositories/user_repository_implementation.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewController extends ChangeNotifier {
  final UserRepository _userRepository;
  final NavigationService _navigationService;

  HomeViewController({
    required NavigationService navigationService,
    required UserRepository userRepository,
  })  : _navigationService = navigationService,
        _userRepository = userRepository;

  Future<void> getCurrentUser() async {
    try {
      await _userRepository.getCurrentUser();
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
}

final loginViewProvider = ChangeNotifierProvider(
  (ref) => HomeViewController(
    navigationService: locator<NavigationService>(),
    userRepository: locator<UserRepositoryImplementation>(),
  ),
);
