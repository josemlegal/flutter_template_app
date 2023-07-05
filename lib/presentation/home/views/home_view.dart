import 'package:flutter/material.dart';
import 'package:flutter_template_app/domain/user/models/user_model.dart';

class HomeView extends StatelessWidget {
  final User currentUser;
  const HomeView({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.name),
      ),
      body: const Center(
        child: Text('Home View is working'),
      ),
    );
  }
}
