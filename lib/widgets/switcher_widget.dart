import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final bool value;
  final Widget title;
  final Widget? subtitle;
  final ValueChanged<bool>? onChange;

  const SwitchWidget({
    Key? key,
    required this.title,
    this.value = false,
    this.onChange,
    this.subtitle,
  }) : super(key: key);

  @override
  SwitchWidgetState createState() => SwitchWidgetState();
}

class SwitchWidgetState extends State<SwitchWidget> {
  bool _isChecked = false;

  @override
  void initState() {
    _isChecked = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SwitchWidget oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        _isChecked = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: widget.subtitle,
      contentPadding: const EdgeInsets.all(0),
      trailing: CupertinoSwitch(
        value: _isChecked,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
            widget.onChange?.call(value);
          });
        },
      ),
    );
  }
}
