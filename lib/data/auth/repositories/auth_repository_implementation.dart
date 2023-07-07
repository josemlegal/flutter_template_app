import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template_app/domain/auth/repositories/auth_repository.dart';

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

  @override
  Future<void> signInWithEmail(
      {required String email, required String password}) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithEmail(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e) {
    rethrow;
  }
}
