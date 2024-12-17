import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final Function(String) onChanged;

  const CustomInputField({
    required this.label,
    required this.onChanged,
    this.inputType = TextInputType.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
