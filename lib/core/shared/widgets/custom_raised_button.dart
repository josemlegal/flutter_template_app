import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  //
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double elevation;
  final VoidCallback? onPressed;
  final Size? size;

  const CustomRaisedButton({
    super.key,
    required this.child,
    required this.color,
    this.borderRadius = 50,
    this.height = 50,
    this.horizontalPadding = 40,
    this.verticalPadding = 0,
    this.elevation = 0,
    this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: size,
          elevation: elevation,
          backgroundColor: color,
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
