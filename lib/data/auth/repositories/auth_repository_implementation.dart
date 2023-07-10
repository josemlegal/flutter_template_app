import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/data/auth/data_sources/auth_data_source.dart';
import 'package:flutter_template_app/domain/auth/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _auth;
  final AuthDataSource _dataSource;

  AuthRepositoryImplementation({
    FirebaseAuth? auth,
    AuthDataSource? dataSource,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _dataSource = dataSource ?? locator<AuthDataSource>();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> signInWithEmail(
          {required String email, required String password}) async =>
      await _call(
          () => _dataSource.signInWithEmail(email: email, password: password));

  @override
  Future<void> signUpWithEmail(
          {required String email, required String password}) async =>
      await _call(
          () => _dataSource.signUpWithEmail(email: email, password: password));
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e) {
    rethrow;
  }
}
