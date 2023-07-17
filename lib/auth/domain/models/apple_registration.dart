import 'dart:io';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleRegistration {
  Future<AuthorizationCredentialAppleID> signInWithApple() async {
    return await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);
  }

  bool get appleLoginIsAvailable => Platform.isIOS;
}
