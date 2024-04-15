import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';

class NoteWidgetFloatingAction extends StatelessWidget {
  final VoidCallback onPressed;

  const NoteWidgetFloatingAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: NoteColors.dark3bColor,
      foregroundColor: NoteColors.whiteColor,
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
