import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';

class NoteWidgetTitleMessage extends StatefulWidget {
  const NoteWidgetTitleMessage({
    super.key,
    required this.textTitleController,
  });

  final TextEditingController textTitleController;

  @override
  State<NoteWidgetTitleMessage> createState() => _TitleMessageState();
}

class _TitleMessageState extends State<NoteWidgetTitleMessage> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      maxLength: 20,
      controller: widget.textTitleController,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: NoteColors.whiteColor,
          ),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: NoteColors.whiteColor,
          ),
        ),
        hintText: NoteStrings.appAlrtDlgTitlHnt,
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: NoteColors.whiteColor,
            ),
      ),
    );
  }
}
