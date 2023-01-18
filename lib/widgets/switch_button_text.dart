import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchButtonText extends StatefulWidget {
  final ValueChanged<int?>? onChange;
  @required
  final List<String>? listNameButton;
  final int page;
  final bool isWeb;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? thumbColor;

  const SwitchButtonText({
    Key? key,
    this.onChange,
    this.page = 0,
    this.listNameButton,
    this.isWeb = false,
    this.style,
    this.backgroundColor,
    this.thumbColor,
  }) : super(key: key);

  @override
  SwitchButtonTextState createState() => SwitchButtonTextState();
}

class SwitchButtonTextState extends State<SwitchButtonText> {
  int? indexTab = 0;
  @override
  void initState() {
    indexTab = widget.page;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isWeb) {
      final listButton = widget.listNameButton
              ?.map((e) => Text(e.toUpperCase(), style: widget.style))
          // ignore: avoid_as
          as Map<int, Widget>;

      return SizedBox(
        width: 200,
        child: CupertinoSegmentedControl(
          selectedColor:
              widget.backgroundColor ?? Theme.of(context).primaryColor,
          unselectedColor:
              widget.backgroundColor ?? Theme.of(context).primaryColorLight,
          borderColor:
              widget.backgroundColor ?? Theme.of(context).primaryColorLight,
          pressedColor:
              widget.backgroundColor ?? Theme.of(context).primaryColorLight,
          children: listButton,
          onValueChanged: (dynamic value) {
            setState(() {
              indexTab = value;
              widget.onChange!(indexTab);
            });
          },
          groupValue: indexTab,
        ),
      );
    }

    final listButton = widget.listNameButton?.map(
      (e) => Text(
        e.toUpperCase(),
        style: widget.style ??
            Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontWeight: FontWeight.w500),
      ),
      // ignore: avoid_as
    ) as Map<int, Widget>;

    return SizedBox(
      width: 200,
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).primaryColorLight,
        thumbColor: widget.thumbColor ?? Theme.of(context).backgroundColor,
        children: listButton,
        onValueChanged: (value) {
          setState(() {
            indexTab = value;
            widget.onChange!(indexTab);
          });
        },
        groupValue: indexTab,
      ),
    );
  }
}
