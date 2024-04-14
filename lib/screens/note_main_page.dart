import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_icons.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/note_widget_gridView.dart';
import 'package:note/widgets/note_widget_iconbutton.dart';
import 'package:note/widgets/note_widget_popUp.dart';

class NoteMainPage extends StatefulWidget {
  const NoteMainPage({super.key});

  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
  final List<NoteGeneralContent> messages = [];
  final Map<String, Color> messageColors = {};

  void _AlertDialogPressed() async {
    popTitleController.clear();
    popExplainController.clear();

    final result = await showDialog<NoteGeneralContent>(
      context: context,
      builder: (context) => NoteWidgetPopUp(
        onSave: _saveText,
      ),
    );
    if (result != null) {
      _saveText(result);
    }
  }

  void _saveText(NoteGeneralContent noteContent) {
    setState(() {
      final randomColor = NoteColors.randomColor();
      messages.add(noteContent);
      messageColors[noteContent.messageTitle] = randomColor;
    });
  }

  void _showListTileDetails(NoteGeneralContent noteContent) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 100,
          color: NoteColors.darkBgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                NoteIcons.icMainShwDlg,
                color: NoteColors.whiteColor,
              ),
              Text(
                'Delete ', // Replace this with your desired content
                style: TextStyle(fontSize: NoteFont.fontSizeTwenty, color: NoteColors.whiteColor),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NoteColors.darkBgColor,
      appBar: AppBar(
        title: Text(
          NoteStrings.appTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: NoteColors.whiteColor,
                fontSize: NoteFont.fontSizeThirtySix,
              ),
        ),
        actions: [
          NoteWidgetIconButton(iconButton: Icons.search, onPressed: () {}),
          NoteWidgetIconButton(iconButton: Icons.info, onPressed: () {}),
        ],
        backgroundColor: NoteColors.darkBgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: NoteWidgetGridView(
          messages: messages,
          messageColors: messageColors,
          onLongPress: _showListTileDetails,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: NoteColors.dark3bColor,
        foregroundColor: NoteColors.whiteColor,
        onPressed: _AlertDialogPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
