import 'package:flutter/material.dart';

class RandomView extends StatelessWidget {
  const RandomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random View'),
      ),
      body: const Center(
        child: Text('Random View'),
      ),
    );
  }
}
