import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/widgets/note_widget_gridView.dart';
import 'package:note/widgets/note_widget_iconbutton.dart';
import 'package:note/widgets/note_widget_popUp.dart';

class NoteMainPage extends StatefulWidget {
  const NoteMainPage({super.key});

  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
  final List<String> messages = [];
  final Map<String, Color> messageColors = {};

  void _AlertDialogPressed() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => NoteWidgetPopUp(
        onSave: _saveText,
      ),
    );
    if (result != null) {
      _saveText(result);
    }
  }

  void _saveText(String text) {
    setState(() {
      final randomColor = NoteColors.randomColor();
      messages.add(text);
      messageColors[text] = randomColor;
    });
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
