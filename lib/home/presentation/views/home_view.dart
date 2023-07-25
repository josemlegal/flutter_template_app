import 'package:flutter/material.dart';
import 'package:flutter_template_app/home/presentation/controllers/home_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// THIS IMPORT IS BEING USED, PLEASE DO NOT REMOVE
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted && ref.read(homeViewProvider).currentUser == null) {
        await ref.read(homeViewProvider.notifier).getCurrentUser();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewController = ref.watch(homeViewProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeViewController.currentUser == null
                ? const CircularProgressIndicator()
                : Text(
                    homeViewController.currentUser!.name,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
