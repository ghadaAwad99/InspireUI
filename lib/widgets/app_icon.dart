import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final Function? onPressed;
  final IconData? icon;
  final double? width;
  final double? height;
  final double sizeIcon;
  final Color? iconColor;
  final Color? splashColor;
  final String? tooltip;
  final String? text;

  const AppIcon({
    Key? key,
    this.onPressed,
    this.width,
    this.height,
    this.tooltip,
    this.icon,
    this.iconColor,
    this.splashColor,
    this.sizeIcon = 18.0,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget button = SizedBox(
      width: width ?? 40,
      height: height ?? 30,
      child: TextButton(
        style: TextButton.styleFrom(
            primary: splashColor ?? Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: 4)),
        onPressed: onPressed as void Function()?,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: sizeIcon,
                color: iconColor ??
                    (onPressed != null
                        ? Theme.of(context).primaryIconTheme.color
                        : Theme.of(context)
                            .primaryIconTheme
                            .color!
                            .withOpacity(0.5)),
              ),
            if (text != null) ...[
              const SizedBox(width: 4),
              Text(
                text!,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: splashColor ??
                          Theme.of(context).colorScheme.secondary,
                      height: 1.6,
                    ),
              ),
            ]
          ],
        ),
      ),
    );

    if (tooltip?.isNotEmpty ?? false) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
