import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/widgets/note_widget_iconbutton.dart';

class NoteMainPage extends StatefulWidget {
  const NoteMainPage({super.key});

  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
  List<Widget> noteList = [];

  void _onPressed() {
    setState(() {
      noteList.add(const Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Text("This is your note area"),
        ),
      ));
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
          NoteWidgetIconButton(
              iconButton: Icons.add,
              onPressed: () {
                _onPressed();
              }),
        ],
        backgroundColor: NoteColors.darkBgColor,
      ),
      body: Center(
        child: ListView(
          children: noteList,
        ) /* NoteWidgetGridView()*/,
      ),
    );
  }
}
