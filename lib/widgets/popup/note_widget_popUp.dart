import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/popup/note_widget_alerttext_buton.dart';
import 'package:note/widgets/popup/note_widget_explain_message.dart';
import 'package:note/widgets/popup/note_widget_icon_color.dart';
import 'package:note/widgets/popup/note_widget_title_message.dart';

// ignore: must_be_immutable
class NoteWidgetPopUp extends StatefulWidget {
  NoteWidgetPopUp({
    super.key,
    required this.onSave,
    required this.id,
  });

  final void Function(NoteGeneralContent, Color) onSave;
  final int id;
  Color? backgroundColor = NoteColors.dark3bColor;
  late List<Widget> scaledIcons;
  @override
  State<NoteWidgetPopUp> createState() => _NoteWidgetPopUpState();
}

final TextEditingController popTitleController = TextEditingController();
final TextEditingController popExplainController = TextEditingController();

class _NoteWidgetPopUpState extends State<NoteWidgetPopUp> {
  @override
  void initState() {
    super.initState();
    widget.scaledIcons = List.generate(NoteColors.rainbowColors.length, (index) {
      return ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(30, 30)),
        child: NoteWidgetIconColor(
          iconButton: Icons.circle,
          iconColor: NoteColors.rainbowColors[index],
          onPressed: () {
            setState(() {
              widget.backgroundColor = NoteColors.rainbowColors[index];
            });
          },
        ),
      );
    });
  }
/*
  void alertButton() {
    final noteContent = NoteGeneralContent(
      id: widget.id,
      messageTitle: popTitleController.text,
      messageContent: popExplainController.text,
    );
    print('Pop id: ${widget.id}');
    widget.onSave(noteContent, widget.backgroundColor!);
    Navigator.of(context).pop();
  }*/

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: NoteColors.darkBgColor,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            NoteWidgetTitleMessage(
              textTitleController: popTitleController,
            ),
            NoteWidgetExplainMessage(
              textExplainController: popExplainController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.scaledIcons,
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
                //    alertButton();
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
