import 'package:flutter/material.dart';

class HomeTile extends StatefulWidget {
  final String toolName;
  final void Function() nav;
  const HomeTile({
    super.key,
    required this.toolName,
    required this.nav,
  });

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Tooltip(
        message: "Navigate to ${widget.toolName}",
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () {
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
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                isPressed
                    ? BoxShadow()
                    : BoxShadow(
                        color: Colors.black,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                        blurStyle: BlurStyle.solid,
                      ),
              ],
            ),
            child: Center(
              child: Text(
                widget.toolName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
