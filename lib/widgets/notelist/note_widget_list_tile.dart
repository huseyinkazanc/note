import 'package:flutter/material.dart';
import 'package:note/features/note_icons.dart';
import 'package:note/notecontent/note_general_content.dart';

class NoteWidgetListTile extends StatelessWidget {
  const NoteWidgetListTile({
    super.key,
    required this.noteContent,
    required this.color,
    required this.textColor,
    required this.isChecked,
    required this.onCheckChanged,
    required this.onEditPressed,
  });

  final NoteGeneralContent noteContent;
  final Color color;
  final Color textColor;
  final bool isChecked;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      title: Text(
        noteContent.messageTitle,
        style: TextStyle(color: textColor),
      ),
      subtitle: Text(noteContent.messageContent),
      leading: Checkbox(
        activeColor: color,
        side: BorderSide(
          color: textColor,
          width: 2.0,
        ),
        value: isChecked,
        onChanged: onCheckChanged,
      ),
      trailing: GestureDetector(
        onTap: onEditPressed,
        child: Icon(
          NoteIcons.icLstGrdPage_trailing,
          color: textColor,
        ),
      ),
    );
  }
}
