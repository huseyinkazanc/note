import 'package:flutter/material.dart';

class NoteWidgetCustomTextButton extends StatelessWidget {
  const NoteWidgetCustomTextButton({
    super.key,
    required this.onPressed,
    required this.alertText,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.fixedSize = const Size(80, 40),
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
  });

  final String alertText;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final Size? fixedSize;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          fixedSize,
        ),
        backgroundColor: MaterialStateProperty.all(
          backgroundColor,
        ),
        foregroundColor: MaterialStateProperty.all(
          foregroundColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(alertText),
    );
  }
}
