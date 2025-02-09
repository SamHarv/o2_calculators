import 'package:flutter/material.dart';

import '../../config/constants.dart';

class InputFieldWidget extends StatefulWidget {
  /// Display [InputFieldWidget] which allows user to input values

  final TextEditingController controller;
  final String label;
  final IconData icon;

  const InputFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.number, // Numeric inputs
      controller: widget.controller,
      decoration: InputDecoration(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        prefixIcon: Icon(widget.icon),
        filled: true,
        fillColor: white,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
