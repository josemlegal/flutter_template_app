import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template_app/domain/user/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _auth;

  AuthRepositoryImplementation({
    required FirebaseAuth auth,
  }) : _auth = auth;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      throw Exception('Error al iniciar sesion');
    }
  }
}
