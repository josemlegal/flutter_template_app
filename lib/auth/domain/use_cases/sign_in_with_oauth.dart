import 'dart:developer';

import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/auth/presentation/controllers/landing_view_controller.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/user/domain/repositories/user_repository.dart';

class SignInWithOAuthUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignInWithOAuthUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> call({required SocialSignIn signInType}) async {
    try {
      if (signInType == SocialSignIn.GoogleSignIn) {
        log('Google Sign In');
        await authRepository.signInWithGoogle();
        log('despues del sign in');
      } else {
        await authRepository.signInWithApple();
      }

      log('antes de checkear la db');
      final userExists = await userRepository.getUser(authRepository.userId!);
      log('despues de la checkear la db');
      log(userExists.toJson().toString());
      if (userExists.name == '') {
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

final signInWithOAuthUseCase = SignInWithOAuthUseCase(
  authRepository: locator<AuthRepository>(),
  userRepository: locator<UserRepository>(),
);
