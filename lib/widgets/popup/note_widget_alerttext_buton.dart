import 'package:flutter/material.dart';

class NoteWidgetAlertTextButton extends StatelessWidget {
  const NoteWidgetAlertTextButton({
    super.key,
    required this.onPressed,
    required this.alertBgColor,
    required this.alertTxtColor,
    required this.alertText,
  });

  final String alertText;
  final Color alertBgColor;
  final Color alertTxtColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          const Size(80, 40),
        ),
        backgroundColor: WidgetStateProperty.all(alertBgColor),
        foregroundColor: WidgetStateProperty.all(alertTxtColor),
      ),
      onPressed: onPressed,
      child: Text(alertText),
    );
  }
}
