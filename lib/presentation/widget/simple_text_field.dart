import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleTextField extends StatelessWidget {
  final String initialValue;
  final String hinttext;
  final String? errorMessage;
  final Function(String)? onChanged;
  final int? maxLenght;
  final Function(String)? onSubmitted;
  final TextInputAction textInputAction;

  const SimpleTextField({
    super.key,
    this.initialValue = '',
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
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        maxLength: maxLenght,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hinttext,
          errorText: errorMessage,
        ),
        textInputAction: textInputAction,
        // onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
