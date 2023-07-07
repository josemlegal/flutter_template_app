import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/domain/user/models/user_model.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final HttpService _httpService;

  UserRepositoryImplementation({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<User> getUser() {
    return _call(() async {
      final response = await _httpService.dio.get("/api/users/1");

      return User.fromJson(response.data);
    });
  }
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e, stack) {
    if (e is FirebaseException) {
      throw CustomErrorHandler.fromFirebaseException(e,
          stack: stack, devMessage: 'User Repository');
    }

    throw CustomErrorHandler.fromGenericError(
        stack: stack,
        devMessage: "UserRepo",
        errorCode: 'user repo error code',
        errorType: 'user-repo-error-type');
  }
}
