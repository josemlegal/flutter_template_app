import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template_app/auth/presentation/controllers/onboarding_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormView extends StatefulHookConsumerWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormViewState();
}

class _FormViewState extends ConsumerState<FormView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: _FormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormWidget extends HookConsumerWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.read(onboardingViewProvider).formKey;
    final onboardingViewController = ref.read(onboardingViewProvider);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name/Lastname',
              ),
              onChanged: (value) {
                onboardingViewController.updateName(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                onboardingViewController.submitForm();
              },
              child: const Text('SUBMIT'),
            )
          ],
        ),
      ),
    );
  }
}
