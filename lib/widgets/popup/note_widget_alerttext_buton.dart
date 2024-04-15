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
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(80, 40),
        ),
        backgroundColor: MaterialStateProperty.all(alertBgColor),
        foregroundColor: MaterialStateProperty.all(alertTxtColor),
      ),
      onPressed: onPressed,
      child: Text(alertText),
    );
  }
}
