import 'package:flutter/material.dart';

class CircleButtonText extends StatelessWidget {
  final String text;
  final double? radius;
  final Color? color;

  const CircleButtonText(
    this.text, {
    Key? key,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: radius! * 2,
      height: radius! * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: color ?? Theme.of(context).primaryColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
