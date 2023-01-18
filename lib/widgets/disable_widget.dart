import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  final Widget child;
  final bool? disable;

  const DisableWidget({
    Key? key,
    required this.child,
    this.disable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const greyscale = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);

    return IgnorePointer(
      ignoring: disable!,
      child: disable!
          ? ColorFiltered(
              colorFilter: greyscale,
              child: child,
            )
          : child,
    );
  }
}
