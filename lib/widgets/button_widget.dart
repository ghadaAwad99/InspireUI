import 'package:flutter/material.dart';

class ButtonWidget extends TextButton {
  ButtonWidget.primary(
    BuildContext context, {
    Key? key,
    required String title,
    Function? onPressed,
    Color? disabledColor,
    Color? color,
    EdgeInsetsGeometry? padding,
  }) : super(
          key: key,
          onPressed: onPressed as void Function()?,
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            padding: padding ?? const EdgeInsets.all(12),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        );
}
