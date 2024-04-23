import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';

class NoteWidgetExplainMessage extends StatefulWidget {
  const NoteWidgetExplainMessage({
    super.key,
    required this.textExplainController,
  });

  final TextEditingController textExplainController;

  @override
  State<NoteWidgetExplainMessage> createState() => _ExplainMessageState();
}

class _ExplainMessageState extends State<NoteWidgetExplainMessage> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textExplainController,
      maxLines: 5,
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
    );
  }
}
