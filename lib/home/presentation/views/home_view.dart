import 'package:flutter/material.dart';
import 'package:flutter_template_app/home/presentation/controllers/home_view_controller.dart';
import 'package:flutter_template_app/user/domain/models/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  final User currentUser;
  const HomeView({super.key, required this.currentUser});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewController = ref.read(homeViewProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.name),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Home View is working'),
            homeViewController.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      homeViewController.checkEmailVerification();
                    },
                    child: const Text('Verificar email'),
                  ),
            homeViewController.isResendingEmailLink
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      homeViewController.sendEmailLink();
                    },
                    child: const Text('Reenviar email'),
                  ),
            ElevatedButton(
              onPressed: () {
                ref.read(homeViewProvider).onLogOut();
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
