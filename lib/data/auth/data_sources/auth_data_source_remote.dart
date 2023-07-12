import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template_app/application/services/shared_preferences_service.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/data/auth/data_sources/auth_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../domain/auth/models/apple_registration.dart';

class AuthDataSourceRemote implements AuthDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final AppleRegistration _appleRegistration;
  final OAuthProvider _googleAuthProvider;
  final OAuthProvider _appleAuthProvider;
  final SharedPreferenceApi _sharedPreferences;

  @override
  bool get userIsSignedIn => _auth.currentUser != null;

  AuthDataSourceRemote({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    OAuthProvider? googleAuthProvider,
    OAuthProvider? appleAuthProvider,
    AppleRegistration? appleRegistration,
    SharedPreferenceApi? sharedPreferences,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _appleRegistration = appleRegistration ?? AppleRegistration(),
        _googleAuthProvider = googleAuthProvider ?? OAuthProvider('google.com'),
        _appleAuthProvider = appleAuthProvider ?? OAuthProvider('apple.com'),
        _sharedPreferences = sharedPreferences ?? SharedPreferencesService();

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

  @override
  Future<String> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID result =
          await _appleRegistration.signInWithApple();

      final givenName = result.givenName;
      final familyName = result.familyName;
      String? userName;
      if (givenName != null && familyName != null) {
        userName = "$givenName $familyName";
      }

      if (userName != null) {
        await _sharedPreferences.setUserName(userName: userName);
      }

      final oAuthCredential = _appleAuthProvider.credential(
          idToken: result.identityToken, accessToken: result.authorizationCode);

      await _auth.signInWithCredential(oAuthCredential);

      if (userName != null && userIsSignedIn) {
        await _auth.currentUser!.updateDisplayName(userName);
      }

      return result.authorizationCode;
    } catch (e) {
      throw CustomError(
          errorCode: "ERROR_ABORTED_BY_USER",
          devMessage: ' Auth Services | socialSignIn',
          longMessage: e.toString(),
          message: 'Ocurrio un error',
          errorType: 'apple_sign_in');
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) {
      throw const CustomError(
          errorCode: 'ERROR_ABORTED_BY_USER',
          message: 'Cancelaste el registro con Google',
          errorType: 'google_auth');
    }
    final googleAuth = await googleAccount.authentication;
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw const CustomError(
          errorCode: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Error al ingresar con Google',
          errorType: 'google_auth');
    }

    final oAuthCredential = _googleAuthProvider.credential(
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken!,
    );
    await _call(() => _auth.signInWithCredential(oAuthCredential));
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

  @override
  String get userId => _auth.currentUser!.uid;
}
