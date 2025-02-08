import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
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
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.number,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Colors.black, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Colors.black, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(color: Colors.black, width: 3),
        ),
        prefixIcon: Icon(widget.icon),
        filled: true,
        fillColor: Colors.white,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
