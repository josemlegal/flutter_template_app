import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/data/auth/data_sources/auth_data_source.dart';

class AuthDataSourceRemote implements AuthDataSource {
  final FirebaseAuth _auth;

  AuthDataSourceRemote({
    required FirebaseAuth auth,
  }) : _auth = auth;

  @override
  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    return await _call(() =>
        _auth.signInWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    return await _call(() =>
        _auth.createUserWithEmailAndPassword(email: email, password: password));
  }

  Future<T> _call<T>(Future<T> Function() function) async {
    try {
      return await function();
    } catch (e, stack) {
      if (e is FirebaseAuthException) {
        throw CustomErrorHandler.fromFirebaseException(
          e,
          stack: stack,
          devMessage: 'Auth Repository',
        );
      }
      if (e is CustomError) {
        rethrow;
      }
      throw CustomErrorHandler.fromGenericError(
        stack: stack,
        errorCode: 'auth-error-code',
        errorType: 'auth-error',
        devMessage: 'AuthRepo',
      );
    }
  }
}
