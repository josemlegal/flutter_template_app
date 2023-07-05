import 'package:dio/dio.dart';
import 'package:flutter_template_app/core/error/custom_error.dart';

class CustomErrorHandler {
  static CustomError fromGenericError({required String message}) {
    return CustomError(message: message);
  }

  static CustomError fromDioError({
    required DioException err,
    required String errorMessage,
  }) {
    var message = "Server error";
    if (err.response != null &&
        err.response!.data != null &&
        err.response!.statusCode == 400) {
      message = errorMessage;
    }
    return CustomError(message: message);
  }
}
