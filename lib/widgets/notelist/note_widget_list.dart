import 'package:flutter/material.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/notelist/note_widget_list_edit.dart';
import 'package:note/widgets/notelist/note_widget_list_tile.dart';

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

  void _alertDialogEdit(NoteGeneralContent noteContent) async {
    final editedContent = await showDialog<NoteGeneralContent>(
      context: context,
      builder: (BuildContext context) {
        return NoteWidgetListEdit(noteContent: noteContent);
      },
    );

    if (editedContent != null) {
      _onSave(noteContent, editedContent); // Pass original and edited content to _onSave
    }
  }

  void _onSave(NoteGeneralContent originalContent, NoteGeneralContent editedContent) {
    // Find the index of the original content in the messages list
    int index = widget.messages.indexWhere((element) => element.messageTitle == originalContent.messageTitle);

    if (index != -1) {
      // If the original content is found, replace it with the edited content
      setState(() {
        // Assign the edited title and content to the original note content
        widget.messages[index].messageTitle = editedContent.messageTitle;
        widget.messages[index].messageContent = editedContent.messageContent;
      });
    }
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
                final color = widget.messageColors[noteContent.messageTitle] ?? Colors.red;
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
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: NoteWidgetListTile(
                      noteContent: noteContent,
                      color: color,
                      textColor: textColor,
                      isChecked: _isCheckedMap[noteContent.messageTitle] ?? false,
                      onCheckChanged: (newValue) {
                        setState(() {
                          _isCheckedMap[noteContent.messageTitle] = newValue ?? false;
                        });
                      },
                      onEditPressed: () {
                        _alertDialogEdit(noteContent);
                      },
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
