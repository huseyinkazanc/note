import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/screens/note_message_page.dart';
import 'package:note/widgets/notelist/note_widget_list_tile.dart';
import 'dart:convert';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView({
    super.key,
    required this.messages,
    required this.messageColors,
    this.onLongPress,
  });

  final List<NoteGeneralContent> messages;
  final Map<String, Color> messageColors; // `int` yerine `String`
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteMessagePage(
          id: noteContent.id,
          onSave: (editedContent, color) {
            _onSave(noteContent.id, editedContent, color); // Pass the ID of the original note and the color
          },
          notTitleController: TextEditingController(text: noteContent.messageTitle),
          notContentController: QuillController(
            document: Document.fromJson(jsonDecode(noteContent.messageContent)), // Convert the string to JSON
            selection: const TextSelection.collapsed(offset: 0),
          ),
          // Pass the initial color
        ),
      ),
    );

    if (result != null) {
      _onSave(noteContent.id, result,
          widget.messageColors[noteContent.id]!); // Pass the ID of the original note and the color
    }
  }

  void _onSave(String id, NoteGeneralContent editedContent, Color color) {
    // Find the index of the original note in the messages list
    int index = widget.messages.indexWhere((element) => element.id == id);

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
        widget.messageColors[id] = color; // Update the color

        print('After updating:');
        print('Message Title: ${widget.messages[index].messageTitle}');
        print('Message Content: ${widget.messages[index].messageContent}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.minHeight),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...widget.messages.map((noteContent) {
                    final color = widget.messageColors[noteContent.id];
                    if (color == null) {
                      return const SizedBox(); // or some other widget to indicate missing color
                    }
                    final textColor = getTextColor(color);
                    return GestureDetector(
                      onLongPress: () {
                        if (widget.onLongPress != null) {
                          widget.onLongPress!(noteContent);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
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
          ),
        );
      },
    );
  }
}
