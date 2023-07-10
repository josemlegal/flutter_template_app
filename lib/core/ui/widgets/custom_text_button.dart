import 'package:flutter/material.dart';

import 'custom_raised_button.dart';

class CustomTextButton extends CustomRaisedButton {
  CustomTextButton({
    required String text,
    Color color = Colors.orange,
    Color textColor = Colors.black,
    double horizontalPadding = 45,
    VoidCallback? onPressed,
    Size? size,
  }) : super(
          child: Text(text, style: TextStyle(color: textColor, fontSize: 18)),
          color: color,
          onPressed: onPressed,
          horizontalPadding: horizontalPadding,
          size: size,
        );
}
