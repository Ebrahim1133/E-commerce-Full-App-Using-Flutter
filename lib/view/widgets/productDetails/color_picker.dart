import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final bool outerBorder;
  final Color color;
  const ColorPicker({
    required this.color,
    required this.outerBorder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: outerBorder ? Border.all(color: color, width: 2) : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
