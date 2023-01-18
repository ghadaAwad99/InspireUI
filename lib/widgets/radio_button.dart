import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final double? radius;
  final bool isActive;
  final Color? color;

  const RadioButton({
    Key? key,
    this.radius,
    this.isActive = false,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colo = color ?? Theme.of(context).primaryColor;
    return Container(
      width: radius! * 2,
      height: radius! * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        border: Border.all(color: isActive ? colo : Colors.grey),
      ),
      padding: const EdgeInsets.all(4.0),
      child: isActive
          ? Container(
              decoration: BoxDecoration(
                color: colo,
                borderRadius: BorderRadius.circular(radius!),
              ),
            )
          : null,
    );
  }
}
