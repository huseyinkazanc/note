import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/widgets/common/note_widget_custom_textbutton.dart';

class NoteWidgetCreateNot extends StatefulWidget {
  const NoteWidgetCreateNot({super.key, required this.alertDialogQuckNotePressed});

  final void Function() alertDialogQuckNotePressed;

  @override
  State<NoteWidgetCreateNot> createState() => _NoteWidgetCreateNotState();
}

class _NoteWidgetCreateNotState extends State<NoteWidgetCreateNot> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: NoteColors.darkBgColor,
      content: SizedBox(
        height: 50.0,
        child: Text(
          textAlign: TextAlign.center,
          NoteStrings.appCreateAlrTxt,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: NoteColors.whiteColor,
              ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NoteWidgetCustomTextButton(
              onPressed: widget.alertDialogQuckNotePressed,
              alertText: NoteStrings.appCreateAlrQuckTxt,
              fixedSize: const Size(125, 40),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              backgroundColor: NoteColors.greenColor,
            ),
            NoteWidgetCustomTextButton(
              onPressed: () {},
              alertText: NoteStrings.appCreateAlrDtlTxt,
              fixedSize: const Size(125, 40),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ],
        ),
      ],
    );
  }
}
