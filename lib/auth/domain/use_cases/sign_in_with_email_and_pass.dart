import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/auth/presentation/controllers/landing_view_controller.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/user/domain/repositories/user_repository.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignInWithEmailAndPasswordUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> call(
      {required SignIn signInType,
      required String email,
      required String password}) async {
    try {
      if (signInType == SignIn.Signup) {
        await authRepository.signUpWithEmail(email: email, password: password);
        return false;
      }
      await authRepository.signInWithEmail(email: email, password: password);
      final userExistOnDB =
          await userRepository.getUser(authRepository.userId!);
      if (userExistOnDB.name == '') {
        return false;
      }
      return true;
    } on CustomError catch (e) {
      throw CustomError(
        errorType: e.errorType,
        errorCode: e.errorCode,
        message: e.message,
      );
    }
  }
}

final signInWithEmailAndPasswordUseCase = SignInWithEmailAndPasswordUseCase(
  authRepository: locator<AuthRepository>(),
  userRepository: locator<UserRepository>(),
);
