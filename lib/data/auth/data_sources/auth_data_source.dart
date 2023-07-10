abstract class AuthDataSource {
  String get userId;

  // String? get userDisplayName;

  // bool get userIsSignedIn;

  // bool get isEmailVerified;

  // String? get userEmail;

  // String? get avatarUrl;
  // Future<void> sendPasswordResetEmail({required String email});
  // Future<String> getIdToken();
  // Future<void> sendEmailVerificationLink();
  // Future<bool> checkEmailVerification();
  // Future<void> logout();
  Future<void> signInWithEmail(
      {required String email, required String password});
  Future<void> signUpWithEmail(
      {required String email, required String password});
  // Future<void> signInWithGoogle();
  // Future<String> signInWithApple();

  // Future<void> deleteUserAccount();
}
