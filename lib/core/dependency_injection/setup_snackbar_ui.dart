import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator.dart';

void setupSnackbarUi() {
  var snackbarService = locator<SnackbarService>();

  snackbarService.registerSnackbarConfig(
    SnackbarConfig(
      backgroundColor: Colors.white,
      messageColor: Colors.black,
      titleColor: Colors.black,
      mainButtonTextColor: Colors.blue,
      padding: const EdgeInsets.all(24),
    ),
  );
}
