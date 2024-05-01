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
  final Map<int, Color> messageColors;
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
      _onSave(noteContent.id, editedContent); // Pass the ID of the original note
    }
  }

  void _onSave(int id, NoteGeneralContent editedContent) {
    // Find the index of the original note in the messages list
    int index = widget.messages.indexWhere((element) => element.id == editedContent.id);

    if (index != -1) {
      print('Original ID: $id');
      print('Edited ID: ${editedContent.id}');
      // If the original note is found, replace it with the edited content
      setState(() {
        print('Before updating:');
        print('Message Title: ${widget.messages[index].messageTitle}');
        print('Message Content: ${widget.messages[index].messageContent}');

        widget.messages[index].messageTitle = editedContent.messageTitle;
        widget.messages[index].messageContent = editedContent.messageContent;

        print('After updating:');
        print('Message Title: ${widget.messages[index].messageTitle}');
        print('Message Content: ${widget.messages[index].messageContent}');
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
                final color = widget.messageColors[noteContent.id];
                final textColor = getTextColor(color!);
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
