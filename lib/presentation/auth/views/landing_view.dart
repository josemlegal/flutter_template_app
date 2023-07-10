// // Flutter imports:
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:morfit/app/UI/widgets/buttons/custom_text_button.dart';
// import 'package:morfit/app/theme/theme_data.dart';

// // Package imports:
// import 'package:stacked/stacked.dart' show ViewModelBuilder;

// // Project imports:

// import 'package:morfit/features/auth/presentation/view_models/landing_view_model.dart';
// import 'package:stacked_hooks/stacked_hooks.dart';

// class LandingView extends StatelessWidget {
//   const LandingView();
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: SafeArea(
//           child: ViewModelBuilder<LandingViewModel>.reactive(
//             viewModelBuilder: () => LandingViewModel(),
//             builder: (context, model, child) {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const _LandingViewHeader(),
//                     const TabBar(
//                       indicatorColor: MorFitColors.primary,
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       tabs: [
//                         Tab(child: Center(child: Text("Iniciar Sesión"))),
//                         Tab(child: Center(child: Text("Crear Cuenta"))),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 400,
//                       child: TabBarView(children: [
//                         _LoginForm(),
//                         _SignUpForm(),
//                       ]),
//                     ),
//                     _LandingButton(
//                       onPressed: model.isBusy
//                           ? null
//                           : () =>
//                               model.signinWithOAuth(SocialSignIn.GoogleSignIn),
//                       buttonLabel: 'Iniciar sesión con Google',
//                       textColor: Colors.black,
//                     ),
//                     const SizedBox(height: 20),
//                     if (model.appleSignInAvailable)
//                       _LandingButton(
//                         buttonLabel: 'Iniciar sesion con Apple',
//                         onPressed: model.isBusy
//                             ? null
//                             : () =>
//                                 model.signinWithOAuth(SocialSignIn.AppleSignIn),
//                         buttonLogo: 'assets/images/apple_logo.png',
//                         textColor: Colors.black,
//                       ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SignUpForm extends StackedHookView<LandingViewModel> {
//   @override
//   Widget builder(BuildContext context, LandingViewModel viewModel) {
//     final email = useTextEditingController(text: viewModel.email);
//     final password = useTextEditingController(text: viewModel.password);
//     final confirmPassord =
//         useTextEditingController(text: viewModel.confirmPassword);

//     if (viewModel.isBusy)
//       return const Center(
//         child: CircularProgressIndicator(),
//       );

//     return Column(
//       children: <Widget>[
//         const SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: TextField(
//             style: const TextStyle(color: Colors.black),
//             keyboardType: TextInputType.emailAddress,
//             controller: email,
//             onChanged: viewModel.updateEmail,
//             decoration: InputDecoration(
//               labelText: 'E-mail',
//               suffixIcon: const Icon(Icons.email_outlined,
//                   color: MorFitColors.primaryDark),
//               errorText: viewModel.emailValidationMessage.isNotEmpty
//                   ? viewModel.emailValidationMessage
//                   : null,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: TextField(
//             style: const TextStyle(color: Colors.black),
//             obscureText: true,
//             controller: password,
//             onChanged: viewModel.updatePassword,
//             decoration: InputDecoration(
//               labelText: 'Contraseña',
//               suffixIcon: const Icon(Icons.password_outlined,
//                   color: MorFitColors.primaryDark),
//               errorText: viewModel.passwordValidationMessage.isNotEmpty
//                   ? viewModel.passwordValidationMessage
//                   : null,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: TextField(
//             style: const TextStyle(color: Colors.black),
//             obscureText: true,
//             controller: confirmPassord,
//             onChanged: viewModel.updateConfirmPassword,
//             decoration: InputDecoration(
//               labelText: 'Repetir Contraseña',
//               suffixIcon: const Icon(Icons.password_outlined,
//                   color: MorFitColors.primaryDark),
//               errorText: viewModel.confirmPasswordValidationMessage.isNotEmpty
//                   ? viewModel.confirmPasswordValidationMessage
//                   : null,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         const SizedBox(height: 30),
//         CustomTextButton(
//           text: 'Crear Cuenta',
//           onPressed: () => viewModel.submitLoginForm(signInType: SignIn.Signup),
//           horizontalPadding: 120,
//         ),
//       ],
//     );
//   }
// }

// class _LoginForm extends StackedHookView<LandingViewModel> {
//   @override
//   Widget builder(BuildContext context, LandingViewModel viewModel) {
//     final email = useTextEditingController(text: viewModel.email);
//     final password = useTextEditingController(text: viewModel.password);
//     if (viewModel.isBusy)
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     return Column(
//       children: <Widget>[
//         const SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: TextField(
//             style: const TextStyle(color: Colors.black),
//             keyboardType: TextInputType.emailAddress,
//             controller: email,
//             onChanged: viewModel.updateEmail,
//             decoration: InputDecoration(
//               labelText: 'E-mail',
//               suffixIcon: const Icon(Icons.email_outlined,
//                   color: MorFitColors.primaryDark),
//               errorText: viewModel.emailValidationMessage.isNotEmpty
//                   ? viewModel.emailValidationMessage
//                   : null,
//             ),
//           ),
//         ),
//         const SizedBox(height: 30),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: TextField(
//             style: const TextStyle(color: Colors.black),
//             obscureText: true,
//             controller: password,
//             onChanged: viewModel.updatePassword,
//             decoration: InputDecoration(
//               labelText: 'Contraseña',
//               suffixIcon: const Icon(Icons.password_outlined,
//                   color: MorFitColors.primaryDark),
//               errorText: viewModel.passwordValidationMessage.isNotEmpty
//                   ? viewModel.passwordValidationMessage
//                   : null,
//             ),
//           ),
//         ),
//         const SizedBox(height: 50),
//         TextButton(
//           onPressed: viewModel.navigateToForgotPassword,
//           child: const Text('Olvidé mi Contraseña',
//               style: TextStyle(
//                   color: MorFitColors.secondaryBlack,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   decoration: TextDecoration.underline)),
//         ),
//         const SizedBox(height: 20),
//         CustomTextButton(
//           text: 'Iniciar Sesión',
//           onPressed: () => viewModel.submitLoginForm(signInType: SignIn.Login),
//           horizontalPadding: 110,
//         ),
//       ],
//     );
//   }
// }

// class _LandingViewHeader extends StatelessWidget {
//   const _LandingViewHeader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 30),
//         Center(
//           child: Image.asset(
//             'assets/images/mf_logo_black_lg.png',
//             width: 200,
//           ),
//         ),
//         const SizedBox(height: 20),
//         Text(
//           "Empezá a morfar, sin culpas ;)",
//           textScaleFactor: 1,
//           style: Theme.of(context).textTheme.displayLarge!.copyWith(
//               color: MorFitColors.primaryDark, fontWeight: FontWeight.w700),
//         ),
//         const SizedBox(height: 50),
//       ],
//     );
//   }
// }

// class _LandingButton extends StatelessWidget {
//   final String buttonLabel;
//   final VoidCallback? onPressed;
//   final String? buttonLogo;
//   final Color? textColor;

//   const _LandingButton({
//     required this.buttonLabel,
//     required this.onPressed,
//     this.buttonLogo,
//     this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       height: 40,
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           padding: const EdgeInsets.all(0),
//           side: const BorderSide(color: MorFitColors.secondaryBlack),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (buttonLogo != null)
//               Image.asset(
//                 buttonLogo!,
//                 width: 20,
//                 height: 20,
//               ),
//             const SizedBox(width: 10),
//             Padding(
//               padding: const EdgeInsets.only(top: 2.0),
//               child: Text(
//                 buttonLabel,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: MorFitColors.secondaryBlack,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
