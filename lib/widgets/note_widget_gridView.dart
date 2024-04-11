import 'package:flutter/material.dart';
import 'package:note/features/note_icons.dart';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView({super.key, required this.messages, required this.messageColors, this.onTap});

  final List<String> messages;
  final Map<String, Color> messageColors;
  final Function(String)? onTap;

  @override
  State<NoteWidgetGridView> createState() => _NoteWidgetGridViewState();
}

class _NoteWidgetGridViewState extends State<NoteWidgetGridView> {
  final Map<String, bool> _isCheckedMap = {};

  Color getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  void initState() {
    super.initState();
    for (final message in widget.messages) {
      _isCheckedMap[message] = false;
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
              ...widget.messages.map((message) {
                // Get the color for the current message from the messageColors map
                final color = widget.messageColors[message];
                final textColor = getTextColor(color!);
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      if (widget.onTap != null) {
                        widget.onTap!(message); // Call onTap function with message parameter
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
                        message,
                        style: TextStyle(color: textColor),
                      ),

                      leading: Checkbox(
                        activeColor: color,
                        side: BorderSide(
                          color: textColor,
                          width: 2.0,
                        ),
                        value: _isCheckedMap[message] ?? false,
                        onChanged: (newValue) {
                          setState(() {
                            _isCheckedMap[message] = newValue ?? false;
                          });
                        },
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
