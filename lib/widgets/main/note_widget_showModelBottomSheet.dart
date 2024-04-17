import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_icons.dart';

class NoteShowModelDetails extends StatelessWidget {
  final VoidCallback onPressed;

  const NoteShowModelDetails({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 100,
        color: NoteColors.darkBgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              NoteIcons.icMainShwDlg,
              color: NoteColors.whiteColor,
            ),
            Text(
              'Delete ',
              style: TextStyle(
                fontSize: NoteFont.fontSizeTwenty,
                color: NoteColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
