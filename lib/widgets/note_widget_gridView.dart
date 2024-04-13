import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_icons.dart';
import 'package:note/features/note_strings.dart';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView(
      {super.key,
      required this.messagesTitle,
      required this.messageColors,
      this.onLongPress,
      this.onTap,
      required this.messagesExplain});

  final List<String> messagesTitle;
  final List<String> messagesExplain;
  final Map<String, Color> messageColors;
  final Function(String)? onLongPress;
  final Function(String)? onTap;

  @override
  State<NoteWidgetGridView> createState() => _NoteWidgetGridViewState();
}

class _NoteWidgetGridViewState extends State<NoteWidgetGridView> {
  final Map<String, bool> _isCheckedMap = {};
  final Map<String, Color> messageColors = {};

  Color getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /* @override
  void initState() {
    super.initState();
    for (final message in widget.messages) {
      _isCheckedMap[message] = false;
    }
  }*/

  void _AlertDialogEdit(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: NoteColors.darkBgColor,
          title: const Text('Edit Message'),
          content: SizedBox(
            height: 250,
            child: Column(
              children: [
                TextFormField(
                  initialValue: message,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: NoteColors.whiteColor,
                      ),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: NoteColors.whiteColor,
                    )),
                    hintText: NoteStrings.appAlrtDlgTitlHnt,
                    hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: NoteColors.whiteColor,
                        ),
                  ),
                  onChanged: (value) {
                    // Handle the changes
                  },
                ),
                TextFormField(
                  initialValue: message,
                  maxLines: 7,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: NoteColors.whiteColor,
                        fontSize: NoteFont.fontSizeEighteen,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: NoteStrings.appAlrtDlgSbjHnt,
                    hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: NoteColors.whiteColor,
                          fontSize: NoteFont.fontSizeEighteen,
                        ),
                  ),
                  onChanged: (value) {
                    // Handle the changes
                  },
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
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
              ...widget.messagesTitle.map((messageTitle) {
                // Get the color for the current message from the messageColors map
                final color = widget.messageColors[messageTitle];
                final textColor = getTextColor(color!);
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      if (widget.onLongPress != null) {
                        widget.onLongPress!(messageTitle);
                      }
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: ListTile(
                      tileColor: color, // Use the color obtained from the messageColors map
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      title: Text(
                        messageTitle,
                        style: TextStyle(color: textColor),
                      ),
                      subtitle: Text(messageTitle),
                      leading: Checkbox(
                        activeColor: color,
                        side: BorderSide(
                          color: textColor,
                          width: 2.0,
                        ),
                        value: _isCheckedMap[messageTitle] ?? false,
                        onChanged: (newValue) {
                          setState(() {
                            _isCheckedMap[messageTitle] = newValue ?? false;
                          });
                        },
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          _AlertDialogEdit(messageTitle);
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
