import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template_app/core/ui/widgets/custom_text_button.dart';
import 'package:flutter_template_app/presentation/auth/controllers/landing_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingView extends HookConsumerWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _LandingViewHeader(),
                // IMPLEMENT REAL COLORS
                TabBar(
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
                SizedBox(
                  height: 400,
                  child: TabBarView(children: [
                    _LoginForm(),
                    _SignUpForm(),
                  ]),
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

    if (landingViewController.isLoading ?? false) {
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

    if (landingViewController.isLoading ?? false) {
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
        Text(
          "Empezá a morfar, sin culpas ;)",
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
