import 'package:flutter/material.dart';
import 'package:flutter_template_app/core/dependency_injection/locator.dart';
import 'package:flutter_template_app/core/router/router.dart' as router;
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MainApp()),
  );

  setupLocator();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: router.Router.loginView,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
