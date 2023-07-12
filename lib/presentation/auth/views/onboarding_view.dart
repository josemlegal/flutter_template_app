import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                child: _FormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormWidget extends HookConsumerWidget {
  _FormWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          // TODO: REPLACE WITH FUNCTION IN THE CONTROLLER
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        ElevatedButton(onPressed: () {}, child: const Text('SUBMIT'))
      ]),
    );
  }
}
