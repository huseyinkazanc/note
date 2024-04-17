import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/popup/note_widget_alerttext_buton.dart';
import 'package:note/widgets/popup/note_widget_explain_message.dart';
import 'package:note/widgets/popup/note_widget_title_message.dart';

class NoteWidgetPopUp extends StatefulWidget {
  const NoteWidgetPopUp({super.key, required this.onSave});

  final void Function(NoteGeneralContent) onSave;

  @override
  State<NoteWidgetPopUp> createState() => _NoteWidgetPopUpState();
}

final TextEditingController popTitleController = TextEditingController();
final TextEditingController popExplainController = TextEditingController();

class _NoteWidgetPopUpState extends State<NoteWidgetPopUp> {
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
            NoteWidgetTitleMessage(
              textTitleController: popTitleController,
            ),
            NoteWidgetExplainMessage(
              textExplainController: popExplainController,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NoteWidgetAlertTextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              alertBgColor: NoteColors.redColor,
              alertTxtColor: NoteColors.whiteColor,
              alertText: NoteStrings.appAlrtBtnDcTxt,
            ),
            NoteWidgetAlertTextButton(
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
