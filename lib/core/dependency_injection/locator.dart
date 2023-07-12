import 'package:flutter_template_app/application/services/auth_service.dart';
import 'package:flutter_template_app/application/services/shared_preferences_service.dart';
import 'package:flutter_template_app/core/services/http_service.dart';
import 'package:flutter_template_app/data/auth/data_sources/auth_data_source.dart';
import 'package:flutter_template_app/data/auth/data_sources/auth_data_source_remote.dart';
import 'package:flutter_template_app/data/auth/repositories/auth_repository_implementation.dart';
import 'package:flutter_template_app/data/user/repositories/user_repository_implementation.dart';
import 'package:flutter_template_app/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_template_app/domain/user/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<SharedPreferenceApi>(
      () => SharedPreferencesService());

  locator.registerLazySingleton<HttpService>(
    () => HttpService(),
  );

  locator.registerLazySingleton<NavigationService>(
    () => NavigationService(),
  );

  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );

  locator.registerLazySingleton<SnackbarService>(
    () => SnackbarService(),
  );

  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceRemote(),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(),
  );

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      httpService: locator<HttpService>(),
      authRepository: locator<AuthRepository>(),
    ),
  );

  locator.registerLazySingleton<AuthService>(
    () => AuthServiceImplementation(
      authRepository: locator<AuthRepository>(),
      userRepository: locator<UserRepository>(),
    ),
  );
}
