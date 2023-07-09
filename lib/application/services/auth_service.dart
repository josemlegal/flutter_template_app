// import 'package:flutter_template_app/core/dependency_injection/locator.dart';
// import 'package:flutter_template_app/domain/user/repositories/auth_repository.dart';
// import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';
// import 'package:flutter_template_app/presentation/auth/controllers/landing_view_controller.dart';

// abstract class AuthService {
//   Future<bool> signInWithEmailAndPassword({
//     required SignIn signInType,
//     required String email,
//     required String password,
//   });
//   // Future<bool> signInWithOAuth({required SocialSignIn signInType});
// }

// class AuthServiceImplementation implements AuthService {
//   final AuthRepository _authRepository;
//   final UserRepository _userRepository;
//   // final AnalyticsApi _analyticsApi;
//   // final SharedPreferenceApi _sharedPreferenceApi;

//   AuthServiceImplementation({
//     AuthRepository? authRepository,
//     UserRepository? userRepository,
//     // SharedPreferenceApi? sharedPreferenceApi,
//     // AnalyticsApi? analyticsApi,
//   })  : _authRepository = authRepository ?? locator<AuthRepository>(),
//         _userRepository = userRepository ?? locator<UserRepository>();
//   // this._sharedPreferenceApi =
//   //     sharedPreferenceApi ?? locator<SharedPreferenceApi>(),
//   // this._analyticsApi = analyticsApi ?? locator<AnalyticsApi>(),
//   @override
//   Future<bool> signInWithEmailAndPassword(
//       {required SignIn signInType,
//       required String email,
//       required String password}) async {
//     if (signInType == SignIn.Signup) {
//       await _authRepository.signUpWithEmail(email: email, password: password);
//       // final utmData = this._sharedPreferenceApi.getUTMValues();
//       // await this._analyticsApi.logCreatedAccount(
//       //       registrationLabel: 'email',
//       //       userId: _authRepository.userId,
//       //       utm_source: utmData['utm_source'],
//       //       utm_medium: utmData['utm_medium'],
//       //       utm_campaign: utmData['utm_campaign'],
//       //     );
//       return false;
//     }
//     await _authRepository.signInWithEmail(email: email, password: password);
//     await _userRepository.getUser();
//     return true;
//   }

//   // @override
//   // Future<bool> signInWithOAuth({required SocialSignIn signInType}) async {
//   //   if (signInType == SocialSignIn.GoogleSignIn) {
//   //     await _authRepository.signInWithGoogle();
//   //   } else {
//   //     await _authRepository.signInWithApple();
//   //   }
//   //   final userExists = await _userRepository.getUser();
//   //   if (userExists) {
//   //     return true;
//   //   }

//   //   final utmData = this._sharedPreferenceApi.getUTMValues();
//   //   await this._analyticsApi.logCreatedAccount(
//   //         registrationLabel:
//   //             signInType == SocialSignIn.GoogleSignIn ? 'google' : 'apple',
//   //         userId: _authRepository.userId,
//   //         utm_source: utmData['utm_source'],
//   //         utm_medium: utmData['utm_medium'],
//   //         utm_campaign: utmData['utm_campaign'],
//   //       );
//   //   return false;
//   // }
// }
