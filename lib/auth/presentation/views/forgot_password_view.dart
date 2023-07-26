// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_template_app/auth/presentation/controllers/forgot_password_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Cambiar Contraseña",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: false,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: _ForgotPasswordEmailController(),
            ),
            SizedBox(height: 20),
            _SubmitPasswordResetButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordEmailController extends HookConsumerWidget {
  const _ForgotPasswordEmailController();

  @override
  Widget build(BuildContext context, ref) {
    final forgotPasswordViewController = ref.watch(forgotPasswordViewProvider);

    final email = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: email,
        onChanged: forgotPasswordViewController.updateEmail,
        decoration: InputDecoration(
          helperText: 'Ingresa tu correo para enviar el link de reset',
          helperStyle: TextStyle(color: Colors.grey[400]),
          labelText: 'Correo Electrónico',
          errorText:
              forgotPasswordViewController.emailValidationMessage.isNotEmpty
                  ? forgotPasswordViewController.emailValidationMessage
                  : null,
        ),
      ),
    );
  }
}

class _SubmitPasswordResetButton extends HookConsumerWidget {
  const _SubmitPasswordResetButton();

  @override
  Widget build(BuildContext context, ref) {
    final forgotPasswordViewController = ref.watch(forgotPasswordViewProvider);

    if (forgotPasswordViewController.isLoading) {
      return const CircularProgressIndicator();
    }

    return ElevatedButton(
      onPressed: forgotPasswordViewController.submitPasswordResetForm,
      child: const Text('Enviar'),
    );
  }
}
