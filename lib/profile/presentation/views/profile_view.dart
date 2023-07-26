import 'package:flutter/material.dart';
import 'package:flutter_template_app/profile/presentation/controllers/profile_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends StatefulHookConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted && ref.read(profileViewProvider).currentUser == null) {
        await ref.read(profileViewProvider.notifier).getCurrentUser();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewController = ref.watch(profileViewProvider);

    return Scaffold(
      appBar: AppBar(
        title: profileViewController.currentUser == null
            ? const CircularProgressIndicator()
            : Text(
                profileViewController.currentUser!.name,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile View',
            ),
            profileViewController.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      profileViewController.checkEmailVerification();
                    },
                    child: const Text('Verificar email'),
                  ),
            profileViewController.isResendingEmailLink
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      profileViewController.sendEmailLink();
                    },
                    child: const Text('Reenviar email'),
                  ),
            ElevatedButton(
              onPressed: () {
                ref.read(profileViewProvider.notifier).onLogOut();
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
