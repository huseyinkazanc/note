import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';

class NoteWidgetPopUp extends StatefulWidget {
  const NoteWidgetPopUp({super.key, required this.onSave}); // Added Key? key parameter

  final void Function(NoteGeneralContent) onSave;

  @override
  State<NoteWidgetPopUp> createState() => _NoteWidgetPopUpState();
}

final TextEditingController popTitleController = TextEditingController(); // Removed 'late' keyword
final TextEditingController popExplainController = TextEditingController(); // Removed 'late' keyword

class _NoteWidgetPopUpState extends State<NoteWidgetPopUp> {
  // Removed initState and dispose methods since controllers are initialized directly

  void alertButton() {
    final noteContent = NoteGeneralContent(
      messageTitle: popTitleController.text,
      messageContent: popExplainController.text,
    );
    widget.onSave(noteContent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: NoteColors.darkBgColor,
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            TitleMessage(
              textTitleController: popTitleController,
            ),
            ExplainMessage(
              textExplainController: popExplainController,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AlertTextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              alertBgColor: NoteColors.redColor,
              alertTxtColor: NoteColors.whiteColor,
              alertText: NoteStrings.appAlrtBtnDcTxt,
            ),
            AlertTextButton(
              onPressed: () {
                alertButton();
              },
              alertBgColor: NoteColors.greenColor,
              alertTxtColor: NoteColors.whiteColor,
              alertText: NoteStrings.appAlrtBtnSvTxt,
            ),
          ],
        ),
      ],
    );
  }
}

class AlertTextButton extends StatelessWidget {
  const AlertTextButton({
    super.key,
    required this.onPressed,
    required this.alertBgColor,
    required this.alertTxtColor,
    required this.alertText,
  });

  final String alertText;
  final Color alertBgColor;
  final Color alertTxtColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(80, 40),
        ),
        backgroundColor: MaterialStateProperty.all(alertBgColor),
        foregroundColor: MaterialStateProperty.all(alertTxtColor),
      ),
      onPressed: onPressed,
      child: Text(alertText),
    );
  }
}

class ExplainMessage extends StatefulWidget {
  const ExplainMessage({
    super.key,
    required this.textExplainController,
  });

  final TextEditingController textExplainController;

  @override
  State<ExplainMessage> createState() => _ExplainMessageState();
}

class _ExplainMessageState extends State<ExplainMessage> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textExplainController,
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
    );
  }
}

class TitleMessage extends StatefulWidget {
  const TitleMessage({
    super.key,
    required this.textTitleController,
  });

  final TextEditingController textTitleController;

  @override
  State<TitleMessage> createState() => _TitleMessageState();
}

class _TitleMessageState extends State<TitleMessage> {
  @override
  Widget build(BuildContext context) {
    return TextField(
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
