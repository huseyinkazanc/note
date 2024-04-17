import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/main/note_widget_floataction.dart';
import 'package:note/widgets/main/note_widget_show_before_delete.dart';
import 'package:note/widgets/notelist/note_widget_list.dart';
import 'package:note/widgets/common/note_widget_iconbutton.dart';
import 'package:note/widgets/popup/note_widget_popUp.dart';
import 'package:note/widgets/main/note_widget_showModelBottomSheet.dart';

class NoteMainPage extends StatefulWidget {
  NoteMainPage({super.key});
  final List<NoteGeneralContent> messages = [];
  final Map<String, Color> messageColors = {};
  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
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
      widget.messages.add(noteContent);
      widget.messageColors[noteContent.messageTitle] = randomColor;
    });
  }

  void _showListTileDetails(NoteGeneralContent noteContent) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NoteShowModelDetails(
          onPressed: () {
            Navigator.pop(context); // Close the details modal
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return NoteWidgetBeforeDelete(
                  onDelete: () {
                    setState(() {
                      widget.messages.remove(noteContent);
                      // widget.messageColors.remove(noteContent.messageTitle);
                      Navigator.pop(context);
                    });
                  },
                );
                // Show the delete confirmation dialog
              },
            );
            // Navigator.pop(context); // Close the bottom sheet
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
          messages: widget.messages,
          messageColors: widget.messageColors,
          onLongPress: _showListTileDetails,
        ),
      ),
      floatingActionButton: NoteWidgetFloatingAction(
        onPressed: _AlertDialogPressed,
      ),
    );
  }
}
