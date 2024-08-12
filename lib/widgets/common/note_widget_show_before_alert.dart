import 'package:flutter/material.dart';

class NoteWidgetBeforeAlert extends StatefulWidget {
  const NoteWidgetBeforeAlert(
      {super.key,
      required this.onDelete,
      required this.alertTitleText,
      required this.alertLeftText,
      required this.alertRightText});

  final VoidCallback onDelete;
  final String alertTitleText;
  final String alertLeftText;
  final String alertRightText;

  @override
  State<NoteWidgetBeforeAlert> createState() => _NoteWidgetBeforeDeleteState();
}

class _NoteWidgetBeforeDeleteState extends State<NoteWidgetBeforeAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.alertTitleText),
      content: Text(
        "Are you sure you want to ${widget.alertTitleText}?",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,
            ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(widget.alertLeftText),
        ),
        TextButton(
          onPressed: widget.onDelete,
          child: Text(widget.alertRightText),
        ),
      ],
    );
  }
}
