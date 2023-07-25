import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template_app/auth/data/data_sources/auth_data_source.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';

class HttpService {
  final _dio = Dio();
  final AuthDataSource _authDataSource = locator<AuthDataSource>();
  String baseUrl = dotenv.env['NGROK_URL'] ?? "";

  HttpService() {
    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final idToken = await _authDataSource.getIdToken();
        options.headers['authorization'] = 'Bearer $idToken';
        return handler.next(options);
      },
    ));
  }
  Dio get dio => _dio;
}
