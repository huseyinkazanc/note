import 'package:flutter/material.dart';

class NoteWidgetTable extends StatelessWidget {
  const NoteWidgetTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: const Text('Number of Notes'),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: const Text('Cell 2'),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: Colors.purple,
                padding: const EdgeInsets.all(8.0),
                child: const Text('Cell 5'),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.orange,
                padding: const EdgeInsets.all(8.0),
                child: const Text('Cell 6'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
