import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/dependency_injection/setup_snackbar_ui.dart';
import 'package:flutter_template_app/core/router/router.dart' as router;
import 'package:stacked_services/stacked_services.dart' as services;
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  setupLocator();
  setupSnackbarUi();
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: services.StackedService.navigatorKey,
      initialRoute: router.Router.landingView,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
