import 'package:flutter/material.dart';

import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';

class NoteMessagePage extends StatefulWidget {
  const NoteMessagePage({super.key});

  @override
  State<NoteMessagePage> createState() => _NoteMessagePageState();
}

class _NoteMessagePageState extends State<NoteMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NoteColors.darkBgColor,
      appBar: AppBar(
        backgroundColor: NoteColors.darkBgColor,
        foregroundColor: NoteColors.whiteColor,
        title: const Text(NoteStrings.appCreateAlrDtlTxt),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              maxLength: 5,
              decoration: InputDecoration(
                hintText: NoteStrings.appAlrtDlgTitlHnt,
              ),
            ),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: NoteStrings.appAlrtDlgSbjHnt,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
