import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';

class NoteWidgetPopUp extends StatefulWidget {
  const NoteWidgetPopUp({super.key, required this.onSave});
  final void Function(String) onSave;

  @override
  State<NoteWidgetPopUp> createState() => NoteWidgetPopUpState();
}

class NoteWidgetPopUpState extends State<NoteWidgetPopUp> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void alertButton() {
      widget.onSave(_controller.text);
      Navigator.of(context).pop();
      //setState(() {});
    }

    return Builder(
      builder: (context) => AlertDialog(
        backgroundColor: NoteColors.darkBgColor,
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              TitleMesage(textTitleController: _controller),
              const ExplainMessage(),
            ],
          ),
        ), // Put the TextField directly in the content
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AlertTextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                AlertBgColor: NoteColors.redColor,
                AlertTxtColor: NoteColors.whiteColor,
                AlertText: NoteStrings.appAlrtBtnDcTxt,
              ),
              AlertTextButton(
                onPressed: () {
                  alertButton();
                },
                AlertBgColor: NoteColors.greenColor,
                AlertTxtColor: NoteColors.whiteColor,
                AlertText: NoteStrings.appAlrtBtnSvTxt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AlertTextButton extends StatelessWidget {
  const AlertTextButton({
    super.key,
    required this.onPressed,
    required this.AlertBgColor,
    required this.AlertTxtColor,
    required this.AlertText,
  });
  final String AlertText;
  final Color AlertBgColor;
  final Color AlertTxtColor;
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
        backgroundColor: MaterialStateProperty.all(AlertBgColor),
        foregroundColor: MaterialStateProperty.all(AlertTxtColor),
      ),
      onPressed: onPressed,
      child: Text(AlertText),
    );
  }
}

class ExplainMessage extends StatelessWidget {
  const ExplainMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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

class TitleMesage extends StatefulWidget {
  const TitleMesage({
    super.key,
    required this.textTitleController,
  });
  final TextEditingController textTitleController;

  @override
  State<TitleMesage> createState() => _TitleMesageState();
}

class _TitleMesageState extends State<TitleMesage> {
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
        )),
        hintText: NoteStrings.appAlrtDlgTitlHnt,
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: NoteColors.whiteColor,
            ),
      ),
    );
  }
}
