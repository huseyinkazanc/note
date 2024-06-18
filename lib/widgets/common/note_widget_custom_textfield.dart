import 'package:flutter/material.dart';

class NotWidgetCustomTextField extends StatelessWidget {
  const NotWidgetCustomTextField(
      {super.key, required this.text, required this.controller, this.obscureText = false, this.autofocus = false});

  final String text;
  final TextEditingController controller;
  final bool obscureText;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintText: text,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 78, 78, 78)),
      ),
    );
  }
}
