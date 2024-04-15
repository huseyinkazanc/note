import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/notecontent/note_general_content.dart';

class NoteWidgetListEdit extends StatelessWidget {
  final NoteGeneralContent noteContent;

  const NoteWidgetListEdit({super.key, required this.noteContent});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: noteContent.messageTitle);
    TextEditingController contentController = TextEditingController(text: noteContent.messageContent);

    return AlertDialog(
      backgroundColor: NoteColors.darkBgColor,
      title: Text(
        'Edit Message',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: NoteColors.whiteColor,
            ),
      ),
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: NoteColors.whiteColor,
                  ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: 6,
              controller: contentController,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: NoteColors.whiteColor,
                  ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Saving the changes
            NoteGeneralContent editedContent = NoteGeneralContent(
              messageTitle: titleController.text,
              messageContent: contentController.text,
            );
            Navigator.of(context).pop(editedContent); // Passing edited content back to the caller
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
