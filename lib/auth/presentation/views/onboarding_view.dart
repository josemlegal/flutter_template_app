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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const FlutterLogo(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox.fromSize(
                size: const Size(200, 200),
                child: const _FormWidget(),
              ),
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
      child: Column(children: [
        TextFormField(
          onChanged: (value) {
            onboardingViewController.updateName(value);
          },
        ),
        ElevatedButton(
            onPressed: () {
              onboardingViewController.submitForm();
            },
            child: const Text('SUBMIT'))
      ]),
    );
  }
}
