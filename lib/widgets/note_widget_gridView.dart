import 'package:flutter/material.dart';
import 'package:note/features/note_icons.dart';
import 'package:note/notecontent/note_general_content.dart';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView({
    super.key,
    required this.messages,
    required this.messageColors,
    this.onLongPress,
    this.onTap,
  });

  final List<NoteGeneralContent> messages;
  final Map<String, Color> messageColors;
  final Function(NoteGeneralContent)? onLongPress;
  final Function(NoteGeneralContent)? onTap;

  @override
  State<NoteWidgetGridView> createState() => _NoteWidgetGridViewState();
}

class _NoteWidgetGridViewState extends State<NoteWidgetGridView> {
  final Map<String, bool> _isCheckedMap = {};

  // Below method is to get the text color based on the background color
  Color getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
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
                // Below is to get the color of the message based on the title
                final color = widget.messageColors[noteContent.messageTitle]!;
                // Below is to get the text color based on the background color
                final textColor = getTextColor(color);
                return GestureDetector(
                  // Below onLongPress is to get the long press event
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
                          if (widget.onTap != null) {
                            widget.onTap!(noteContent);
                          }
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
