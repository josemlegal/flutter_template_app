import 'package:flutter/material.dart';
import 'package:flutter_template_app/home/presentation/controllers/home_view_controller.dart';
import 'package:flutter_template_app/user/domain/models/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  final User currentUser;
  const HomeView({super.key, required this.currentUser});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.name),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Home View is working'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(homeViewProvider).onLogOut();
            },
            child: const Text('LOGOUT'),
          )
        ],
      ),
    );
  }
}
