import 'package:flutter/material.dart';
import 'dart:math';

class NoteColors {
  static Color darkBgColor = const Color.fromARGB(255, 37, 37, 37);
  static Color dark3bColor = const Color.fromARGB(255, 59, 59, 59);
  static Color whiteColor = Colors.white;
  static Color greyColor = Colors.grey;
  static Color greenColor = Colors.green;
  static Color redColor = Colors.red;
  static Color randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  static List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
}
