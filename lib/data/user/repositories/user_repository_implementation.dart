import 'package:dio/dio.dart';
import 'package:flutter_template_app/core/error/error_handling.dart';
import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/domain/user/models/user_model.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final HttpService _httpService;

  UserRepositoryImplementation({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<User> getCurrentUser() {
    return _call(() async {
      final response = await _httpService.dio.get("/api/users/1");

      return User.fromJson(response.data);
    }, errorMessage: "Could not get current user.");
  }
}

Future<T> _call<T>(Future<T> Function() function,
    {String? errorMessage}) async {
  try {
    return await function();
  } on DioException catch (err) {
    throw CustomErrorHandler.fromDioError(
      err: err,
      errorMessage:
          errorMessage ?? "Something went wrong, please try again later.",
    );
  } catch (err) {
    throw CustomErrorHandler.fromGenericError(message: err.toString());
  }
}
