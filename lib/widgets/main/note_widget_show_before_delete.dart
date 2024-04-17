import 'package:flutter/material.dart';

class NoteWidgetBeforeDelete extends StatefulWidget {
  const NoteWidgetBeforeDelete({super.key, required this.onDelete});

  final VoidCallback onDelete;

  @override
  State<NoteWidgetBeforeDelete> createState() => _NoteWidgetBeforeDeleteState();
}

class _NoteWidgetBeforeDeleteState extends State<NoteWidgetBeforeDelete> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Note"),
      content: const Text("Are you sure you want to delete this note?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: widget.onDelete,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
