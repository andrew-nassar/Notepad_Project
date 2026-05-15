import 'package:flutter/material.dart';

class CustomNoteField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextStyle style;
  final int? maxLines;

  const CustomNoteField({
    super.key,
    required this.controller,
    required this.hint,
    required this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // [cite: 23, 26]
      maxLines: maxLines, // [cite: 26]
      style: style, // [cite: 23, 26]
      decoration: InputDecoration(
        hintText: hint, // [cite: 24, 27]
        border: InputBorder.none, // [cite: 25, 27]
        hintStyle: const TextStyle(color: Colors.black12), // [cite: 27]
      ),
    );
  }
}