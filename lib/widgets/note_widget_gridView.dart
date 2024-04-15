import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_icons.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/note_widget_popUp.dart';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView({
    super.key,
    required this.messages,
    required this.messageColors,
    this.onLongPress,
  });

  final List<NoteGeneralContent> messages;
  final Map<String, Color> messageColors;
  final Function(NoteGeneralContent)? onLongPress;

  @override
  State<NoteWidgetGridView> createState() => _NoteWidgetGridViewState();
}

class _NoteWidgetGridViewState extends State<NoteWidgetGridView> {
  final Map<String, bool> _isCheckedMap = {};

  Color getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  void _AlertDialogEdit(NoteGeneralContent noteContent) {
    final TextEditingController titleController = TextEditingController(text: noteContent.messageTitle);
    final TextEditingController contentController = TextEditingController(text: noteContent.messageContent);

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                TitleMessage(
                  textTitleController: titleController,
                ),
                ExplainMessage(
                  textExplainController: contentController,
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
                final editedNoteContent = NoteGeneralContent(
                  messageTitle: titleController.text,
                  messageContent: contentController.text,
                );
                _onSave(editedNoteContent); // Call the _onSave method
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _onSave(NoteGeneralContent editedContent) {
    setState(() {
      final index = widget.messages.indexWhere((element) => element.messageTitle == editedContent.messageTitle);
      if (index != -1) {
        widget.messages[index] = editedContent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.minHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Below is the header of the grid view
              ...widget.messages.map((noteContent) {
                final color = widget.messageColors[noteContent.messageTitle]!;
                final textColor = getTextColor(color);
                return GestureDetector(
                  onLongPress: () {
                    if (widget.onLongPress != null) {
                      widget.onLongPress!(noteContent);
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: ListTile(
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
                        value: _isCheckedMap[noteContent.messageTitle] ?? false,
                        onChanged: (newValue) {
                          setState(() {
                            _isCheckedMap[noteContent.messageTitle] = newValue ?? false;
                          });
                        },
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          _AlertDialogEdit(noteContent);
                        },
                        child: Icon(
                          NoteIcons.icLstGrdPage_trailing,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
