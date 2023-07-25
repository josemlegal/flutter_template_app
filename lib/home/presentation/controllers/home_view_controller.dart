import 'package:flutter/foundation.dart';
import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/user/domain/models/user_model.dart';
import 'package:flutter_template_app/user/domain/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewController extends ChangeNotifier {
  final UserRepository _userRepository;

  User? _currentUser;

  HomeViewController({
    required NavigationService navigationService,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required SnackbarService snackbarService,
  }) : _userRepository = userRepository;

  User? get currentUser => _currentUser;
  Future<void> getCurrentUser() async {
    try {
      _currentUser = await _userRepository.getUser(_userRepository.userId!);
      notifyListeners();
    } catch (err) {
      print(err);
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
