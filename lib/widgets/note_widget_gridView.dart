import 'package:flutter/material.dart';

class NoteWidgetGridView extends StatefulWidget {
  const NoteWidgetGridView({super.key});

  @override
  State<NoteWidgetGridView> createState() => _NoteWidgetGridViewState();
}

class _NoteWidgetGridViewState extends State<NoteWidgetGridView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.minHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              50,
              (index) => Card(
                child: Text("kakdsjkfjdfkl" * 12),
              ),
            ),
          ),
        ),
      );
    });
  }
}
