import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/auth/presentation/controllers/landing_view_controller.dart';
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
    // TODO: ADD TRY CATCH BLOCK
    if (signInType == SignIn.Signup) {
      await authRepository.signUpWithEmail(email: email, password: password);
      return false;
    }
    await authRepository.signInWithEmail(email: email, password: password);
    await userRepository.getUser(authRepository.userId!);
    return true;
  }
}
