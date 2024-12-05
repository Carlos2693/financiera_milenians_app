import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  final String hinttext;

  const SimpleTextField({
    super.key,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hinttext,
        ),
      ),
    );
  }
}
