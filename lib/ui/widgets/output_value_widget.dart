import '../../config/constants.dart';
import 'package:flutter/material.dart';

class OutputValueWidget extends StatelessWidget {
  /// Display [OutputValueWidget] which shows the output values for dialog

  final String label;
  final String value;

  const OutputValueWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: outputValueStyle),
        Text(value, style: outputValueStyle),
      ],
    );
  }
}
