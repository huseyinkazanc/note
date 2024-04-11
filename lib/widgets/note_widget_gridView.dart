import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView({super.key, required this.messages, required this.messageColors});

  final List<String> messages;
  final Map<String, Color> messageColors;

  @override
  State<NoteWidgetGridView> createState() => _NoteWidgetGridViewState();
}

class _NoteWidgetGridViewState extends State<NoteWidgetGridView> {
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
                return Card(
                  child: ListTile(
                    tileColor: color, // Use the color obtained from the messageColors map
                    title: Text(message),
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
