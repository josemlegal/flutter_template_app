import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthRepository {
  Future<void> signUpWithEmail(
      {required String email, required String password});
  Future<void> signInWithEmail(
      {required String email, required String password});

  Future<void> signInWithGoogle();
  Future<void> signInWithApple();

  //Getters
  auth.User? get currentUser;
  String? get userEmail;
  String get userId;
}
