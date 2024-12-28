import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleTextField extends StatelessWidget {
  final String hinttext;
  final String? errorMessage;
  final Function(String)? onChanged;
  final int? maxLenght;
  final Function(String)? onSubmitted;
  final TextInputAction textInputAction;

  const SimpleTextField({
    super.key,
    required this.hinttext,
    this.errorMessage,
    this.onChanged,
    this.maxLenght,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        onChanged: onChanged,
        maxLength: maxLenght,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hinttext,
          errorText: errorMessage,
        ),
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
