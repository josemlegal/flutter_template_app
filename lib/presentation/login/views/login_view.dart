import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template_app/presentation/login/controllers/login_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class LoginView extends HookConsumerWidget {
  TextEditingController controller = TextEditingController();
  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewController = ref.read(loginViewProvider);
    final keyForm = GlobalKey<FormState>();
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: FadeIn(
        duration: const Duration(seconds: 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(
                  size: 100,
                ),
                _UsernameInput(loginController: loginViewController),
                _PasswordInput(loginController: loginViewController),
                const SizedBox(
                  height: 30,
                ),
                _SubmitButton(
                  colors: colors,
                  keyForm: keyForm,
                  loginController: loginViewController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    required this.loginController,
  });

  final LoginViewController loginController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\d'))],
      validator: loginController.textInputEmptyValidator,
      decoration: InputDecoration(
        labelText: 'Username',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.primary),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    required this.loginController,
  });

  final LoginViewController loginController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
      ],
      validator: loginController.textInputEmptyValidator,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Password',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.primary),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.colors,
    required this.keyForm,
    required this.loginController,
  });

  final ColorScheme colors;
  final GlobalKey<FormState> keyForm;
  final LoginViewController loginController;

  @override
  Widget build(BuildContext context) {
    return FadeInUpBig(
      child: SizedBox(
        width: double.infinity,
        child: FloatingActionButton.extended(
          backgroundColor: colors.primary,
          label: Text('Login',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.white70, fontWeight: FontWeight.w900)),
          onPressed: () {
            if (keyForm.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loading...'),
                ),
              );
            }
            loginController.getCurrentUser();
          },
        ),
      ),
    );
  }
}
