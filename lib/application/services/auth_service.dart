import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';
import 'package:flutter_template_app/presentation/auth/controllers/landing_view_controller.dart';

abstract class AuthService {
  Future<bool> signInWithEmailAndPassword({
    required SignIn signInType,
    required String email,
    required String password,
  });
}

class AuthServiceImplementation implements AuthService {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthServiceImplementation({
    AuthRepository? authRepository,
    UserRepository? userRepository,
  })  : _authRepository = authRepository ?? locator<AuthRepository>(),
        _userRepository = userRepository ?? locator<UserRepository>();

  @override
  Future<bool> signInWithEmailAndPassword(
      {required SignIn signInType,
      required String email,
      required String password}) async {
    if (signInType == SignIn.Signup) {
      await _authRepository.signUpWithEmail(email: email, password: password);

      return false;
    }
    await _authRepository.signInWithEmail(email: email, password: password);
    await _userRepository.getUser();
    return true;
  }
}
