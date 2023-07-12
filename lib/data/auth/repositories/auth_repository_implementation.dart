import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template_app/application/services/shared_preferences_service.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/data/auth/data_sources/auth_data_source.dart';
import 'package:flutter_template_app/domain/auth/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _auth;
  final AuthDataSource _dataSource;
  final SharedPreferenceApi _sharedPreferenceApi;
  final FirebaseFunctions _cloudFunctions;

  AuthRepositoryImplementation({
    FirebaseAuth? auth,
    AuthDataSource? dataSource,
    SharedPreferenceApi? sharedPreferenceApi,
    FirebaseFunctions? cloudFunctions,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _dataSource = dataSource ?? locator<AuthDataSource>(),
        _sharedPreferenceApi =
            sharedPreferenceApi ?? locator<SharedPreferenceApi>(),
        _cloudFunctions = cloudFunctions ?? FirebaseFunctions.instance;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  String? get userEmail => _auth.currentUser?.email;

  @override
  String get userId => _auth.currentUser!.uid;

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

  @override
  Future<void> signInWithApple() async {
    return await _call(() async {
      final authCode = await _dataSource.signInWithApple();
      final appleTokenFunction =
          _cloudFunctions.httpsCallable('getAppleRefreshToken');

      final result =
          await appleTokenFunction.call<String?>({'token': authCode});
      if (result.data != null) {
        await _sharedPreferenceApi.setAppleRefreshToken(result.data!);
      }
    });
  }

  @override
  Future<void> signInWithGoogle() async =>
      await _call(() => _dataSource.signInWithGoogle());
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e) {
    rethrow;
  }
}
