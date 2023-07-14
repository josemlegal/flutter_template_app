import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template_app/core/ui/widgets/custom_text_button.dart';
import 'package:flutter_template_app/presentation/auth/controllers/landing_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingView extends HookConsumerWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final landingViewController = ref.read(landingViewControllerProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _LandingViewHeader(),
                const TabBar(
                  indicatorColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  tabs: [
                    Tab(
                      child: Center(
                          child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                    Tab(
                        child: Center(
                            child: Text(
                      "Crear Cuenta",
                      style: TextStyle(color: Colors.black),
                    ))),
                  ],
                ),
                const SizedBox(
                  height: 360,
                  child: TabBarView(children: [
                    _LoginForm(),
                    _SignUpForm(),
                  ]),
                ),
                _LandingButton(
                  buttonLabel: 'Iniciar sesión con Google',
                  onPressed: landingViewController.isLoading
                      ? null
                      : () => landingViewController
                          .signinWithOAuth(SocialSignIn.GoogleSignIn),
                  buttonLogo: 'assets/images/apple_logo.png',
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                // TODO : CHECK IF LOGIN WITH APPLE IS AVAILABLE
                _LandingButton(
                  buttonLabel: 'Iniciar sesión con Apple',
                  onPressed: landingViewController.isLoading
                      ? null
                      : () => landingViewController
                          .signinWithOAuth(SocialSignIn.AppleSignIn),
                  buttonLogo: 'assets/images/apple_logo.png',
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulHookConsumerWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<_SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final landingViewController = ref.read(landingViewControllerProvider);
    final email = useTextEditingController(text: landingViewController.email);
    final password =
        useTextEditingController(text: landingViewController.password);
    final confirmPassord =
        useTextEditingController(text: landingViewController.confirmPassword);

    if (landingViewController.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.emailAddress,
            controller: email,
            onChanged: landingViewController.updateEmail,
            decoration: InputDecoration(
              labelText: 'E-mail',
              suffixIcon: const Icon(Icons.email_outlined, color: Colors.black),
              errorText: landingViewController.emailValidationMessage.isNotEmpty
                  ? landingViewController.emailValidationMessage
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            obscureText: true,
            controller: password,
            onChanged: landingViewController.updatePassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon:
                  const Icon(Icons.password_outlined, color: Colors.black),
              errorText:
                  landingViewController.passwordValidationMessage.isNotEmpty
                      ? landingViewController.passwordValidationMessage
                      : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            obscureText: true,
            controller: confirmPassord,
            onChanged: landingViewController.updateConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Repetir Contraseña',
              suffixIcon:
                  const Icon(Icons.password_outlined, color: Colors.black),
              errorText: landingViewController
                      .confirmPasswordValidationMessage.isNotEmpty
                  ? landingViewController.confirmPasswordValidationMessage
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 30),
        CustomTextButton(
          text: 'Crear Cuenta',
          onPressed: () =>
              landingViewController.submitLoginForm(signInType: SignIn.Signup),
          horizontalPadding: 120,
        ),
      ],
    );
  }
}

class _LoginForm extends StatefulHookConsumerWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController(text: 'email');
    final password = useTextEditingController(text: 'pass');
    final landingViewController = ref.read(landingViewControllerProvider);

    if (landingViewController.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.emailAddress,
            controller: email,
            onChanged: landingViewController.updateEmail,
            decoration: InputDecoration(
              labelText: 'E-mail',
              suffixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              errorText: landingViewController.emailValidationMessage.isNotEmpty
                  ? landingViewController.emailValidationMessage
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            obscureText: true,
            controller: password,
            onChanged: landingViewController.updatePassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: const Icon(
                Icons.password_outlined,
                color: Colors.black,
              ),
              errorText:
                  landingViewController.passwordValidationMessage.isNotEmpty
                      ? landingViewController.passwordValidationMessage
                      : null,
            ),
          ),
        ),
        const SizedBox(height: 50),
        TextButton(
          onPressed: landingViewController.navigateToForgotPassword,
          child: const Text(
            'Olvidé mi Contraseña',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomTextButton(
          text: 'Iniciar Sesión',
          onPressed: () =>
              landingViewController.submitLoginForm(signInType: SignIn.Login),
          horizontalPadding: 110,
        ),
      ],
    );
  }
}

class _LandingViewHeader extends StatelessWidget {
  const _LandingViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 30),
        Center(
          child: FlutterLogo(
            size: 100,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class _LandingButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback? onPressed;
  final String? buttonLogo;
  final Color? textColor;

  const _LandingButton({
    required this.buttonLabel,
    required this.onPressed,
    this.buttonLogo,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side: const BorderSide(color: Colors.indigo),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonLogo != null)
              Image.asset(
                buttonLogo!,
                width: 20,
                height: 20,
              ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                buttonLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
