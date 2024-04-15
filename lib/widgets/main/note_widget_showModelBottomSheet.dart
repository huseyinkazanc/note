import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_icons.dart';

class NoteShowModelDetails extends StatelessWidget {
  final VoidCallback onDelete;

  const NoteShowModelDetails({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDelete,
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
