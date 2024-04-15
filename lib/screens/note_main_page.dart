import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/main/note_widget_floataction.dart';
import 'package:note/widgets/notelist/note_widget_list.dart';
import 'package:note/widgets/common/note_widget_iconbutton.dart';
import 'package:note/widgets/popup/note_widget_popUp.dart';
import 'package:note/widgets/main/note_widget_showModelBottomSheet.dart';

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
        return NoteShowModelDetails(
          onDelete: () {
            setState(() {
              // Remove the noteContent from the messages list
              messages.remove(noteContent);
              // Remove the color associated with the noteContent's title from the messageColors map
              messageColors.remove(noteContent.messageTitle);
            });
            Navigator.pop(context); // Close the bottom sheet
          },
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
      floatingActionButton: NoteWidgetFloatingAction(
        onPressed: _AlertDialogPressed,
      ),
    );
  }
}
