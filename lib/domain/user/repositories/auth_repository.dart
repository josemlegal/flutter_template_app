import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);

  auth.User? get currentUser;
}
