import 'dart:developer';

import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/user/domain/repositories/user_repository.dart';
import 'package:flutter_template_app/auth/presentation/controllers/landing_view_controller.dart';

// TODO: WE SHOULD REMOVE THIS FILE AFTER WE FINISH THE MIGRATION TO THE USE CASES

abstract class AuthService {
  // Future<bool> signInWithEmailAndPassword({
  //   required SignIn signInType,
  //   required String email,
  //   required String password,
  // });
  // Future<bool> signInWithOAuth({required SocialSignIn signInType});
}

class AuthServiceImplementation implements AuthService {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthServiceImplementation({
    AuthRepository? authRepository,
    UserRepository? userRepository,
  })  : _authRepository = authRepository ?? locator<AuthRepository>(),
        _userRepository = userRepository ?? locator<UserRepository>();

  // @override
  // Future<bool> signInWithEmailAndPassword(
  //     {required SignIn signInType,
  //     required String email,
  //     required String password}) async {
  //   if (signInType == SignIn.Signup) {
  //     await _authRepository.signUpWithEmail(email: email, password: password);

  //     return false;
  //   }
  //   await _authRepository.signInWithEmail(email: email, password: password);
  //   await _userRepository.getUser(_authRepository.userId!);
  //   return true;
  // }

  // @override
  // Future<bool> signInWithOAuth({required SocialSignIn signInType}) async {
  //   if (signInType == SocialSignIn.GoogleSignIn) {
  //     log('Google Sign In');
  //     await _authRepository.signInWithGoogle();
  //     log('despues del sign in');
  //   } else {
  //     await _authRepository.signInWithApple();
  //   }

  //   log('antes de checkear la db');
  //   final userExists =
  //       await _userRepository.getUser(_authRepository.currentUser!.uid);
  //   log('despues de la checkear la db');
  //   log(userExists.toJson().toString());
  //   if (userExists.name == '') {
  //     return false;
  //   }
  //   return true;
  // }
}
