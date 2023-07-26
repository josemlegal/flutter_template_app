import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template_app/application/services/shared_preferences_service.dart';
import 'package:flutter_template_app/core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/dependency_injection/setup_snackbar_ui.dart';
import 'package:flutter_template_app/core/router/router.dart' as router;
import 'package:stacked_services/stacked_services.dart' as services;
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  final sharedPreferences = locator<SharedPreferenceApi>();
  await sharedPreferences.init();
  setupSnackbarUi();
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  bool get isUserLoggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      navigatorKey: services.StackedService.navigatorKey,
      initialRoute:
          isUserLoggedIn ? router.Router.tabsView : router.Router.landingView,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
