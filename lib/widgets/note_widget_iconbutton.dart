import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';

class NoteWidgetIconButton extends StatelessWidget {
  final IconData iconButton;
  final VoidCallback? onPressed;
  const NoteWidgetIconButton({super.key, required this.iconButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(iconButton),
        onPressed: onPressed,
        style: TextButton.styleFrom(
            iconColor: NoteColors.whiteColor,
            backgroundColor: NoteColors.dark3bColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )));
  }
}
