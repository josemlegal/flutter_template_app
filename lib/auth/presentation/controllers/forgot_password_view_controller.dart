import 'package:flutter/foundation.dart';
import 'package:flutter_template_app/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/core/mixins/validation_mixin.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordController extends ChangeNotifier with Validation {
  final AuthRepository _authService;
  final SnackbarService _snackbarService;

  String _email = '';
  String _emailValidationMessage = '';

  ForgotPasswordController({
    AuthRepository? auth,
    SnackbarService? snackbarService,
  })  : _authService = auth ?? locator<AuthRepository>(),
        _snackbarService = snackbarService ?? locator<SnackbarService>();

  String get email => _email;
  String get emailValidationMessage => _emailValidationMessage;

  // Flags
  bool isLoading = false;

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  Future<void> submitPasswordResetForm() async {
    _emailValidationMessage = validateEmail(_email);
    if (_emailValidationMessage.isNotEmpty) {
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      await _authService.sendPasswordResetEmail(email: email);
      _snackbarService.showSnackbar(
        message: 'Se ha enviado el link a tu correo',
      );
    } on CustomError catch (e) {
      _snackbarService.showSnackbar(message: e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

final forgotPasswordViewProvider =
    ChangeNotifierProvider<ForgotPasswordController>(
  (ref) => ForgotPasswordController(
    auth: locator<AuthRepository>(),
    snackbarService: locator<SnackbarService>(),
  ),
);
