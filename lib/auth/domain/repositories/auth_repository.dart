import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthRepository {
  Future<void> signUpWithEmail(
      {required String email, required String password});
  Future<void> signInWithEmail(
      {required String email, required String password});

  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> logout();

  //Methods for password reset
  Future<void> sendPasswordResetEmail({required String email});

  //Methods for email verification
  Future<bool> checkEmailVerification();
  Future<void> sendEmailVerificationLink();

  //Getters
  auth.User? get currentUser;
  String? get userEmail;
  String? get userId;
}
