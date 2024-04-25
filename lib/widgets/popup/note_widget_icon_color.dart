import 'package:flutter/material.dart';

class NoteWidgetIconColor extends StatelessWidget {
  const NoteWidgetIconColor({super.key, required this.iconButton, this.onPressed, required this.iconColor});
  final IconData iconButton;
  final VoidCallback? onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      icon: Icon(
        iconButton,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
