import 'package:calculators/config/constants.dart';
import 'package:flutter/material.dart';

class HomeTileWidget extends StatefulWidget {
  /// Display [HomeTileWidget] which allows navigation to different tools

  final String toolName;
  final void Function() nav;

  const HomeTileWidget({
    super.key,
    required this.toolName,
    required this.nav,
  });

  @override
  State<HomeTileWidget> createState() => _HomeTileWidgetState();
}

class _HomeTileWidgetState extends State<HomeTileWidget> {
  // For button press animation
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Tooltip(
        message: "Navigate to ${widget.toolName}",
        child: InkWell(
          borderRadius: kBorderRadius,
          onTap: () {
            // Button press animation
            setState(() {
              isPressed = true;
            });
            Future.delayed(const Duration(milliseconds: 150)).then((value) {
              setState(() {
                isPressed = false;
              });
              widget.nav();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: black, width: 3),
              borderRadius: kBorderRadius,
              boxShadow: [isPressed ? BoxShadow() : kShadow],
            ),
            child: Center(
              child: Text(
                widget.toolName,
                textAlign: TextAlign.center,
                style: subHeadingStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
