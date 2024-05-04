import 'package:flutter/material.dart';

class NoteMessagePage extends StatefulWidget {
  const NoteMessagePage({super.key});

  @override
  State<NoteMessagePage> createState() => _NoteMessagePageState();
}

class _NoteMessagePageState extends State<NoteMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Message Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
