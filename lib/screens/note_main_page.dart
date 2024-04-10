import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/widgets/note_widget_iconbutton.dart';
import 'package:note/widgets/note_widget_popUp.dart';

class NoteMainPage extends StatefulWidget {
  const NoteMainPage({super.key});

  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
  List<String> noteList = ["Note 1", "Note 2", "Note 3"];

  /*void _onPressed() {
    setState(() {
      noteList.add(const Padding(
        padding: EdgeInsets.all(2.0),
        child: SizedBox(
          height: 100,
          child: NoteWidgetPopUp(),
        ),
      ));
    });
  }*/

  void _AlertDialogPressed() {
    showDialog(
      context: context,
      builder: (context) => const NoteWidgetPopUp(),
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
        child: Center(
          child: ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(noteList[index]),
              );
            },
          ),
          /* NoteWidgetGridView()*/
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: NoteColors.dark3bColor,
        foregroundColor: NoteColors.whiteColor,
        child: const Icon(Icons.add),
        onPressed: () {
          _AlertDialogPressed();
        },
      ),
    );
  }
}
