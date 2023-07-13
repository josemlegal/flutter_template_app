import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_template_app/domain/user/models/user_model.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final HttpService _httpService;
  final AuthRepository _authRepository;

  UserRepositoryImplementation(
      {required HttpService httpService,
      required AuthRepository authRepository})
      : _httpService = httpService,
        _authRepository = authRepository;

  @override
  String get userId => _authRepository.userId;

  @override
  Future<User> getUser(String id) {
    return _call(() async {
      final response = await _httpService.dio.get("/api/users/$id");
      log(response.toString());

      return User.fromJson(response.data);
    });
  }

  @override
  Future<User> createNewUser(User user) {
    return _call(() async {
      final response =
          await _httpService.dio.post("/api/users", data: user.toJson());

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
