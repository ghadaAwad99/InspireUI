import 'package:flutter/material.dart';

class TextShowMore extends StatefulWidget {
  final String text;
  final int limitCharacter;
  final TextStyle textStyle;

  const TextShowMore({
    Key? key,
    required this.text,
    this.limitCharacter = 150,
    this.textStyle = const TextStyle(
      fontSize: 12,
      decoration: TextDecoration.none,
      color: Color.fromRGBO(24, 24, 24, 1),
    ),
  }) : super(key: key);

  @override
  TextShowMoreState createState() => TextShowMoreState();
}

class TextShowMoreState extends State<TextShowMore> {
  late String firstDesc;
  late String secondDesc;
  bool isShowLess = true;

  Widget _text(String text, color) => Text(text, style: widget.textStyle);
  String? text;

  @override
  void initState() {
    text = widget.text;

    updateText();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextShowMore oldWidget) {
    if (oldWidget.text != widget.text) {
      setState(updateText);
    }
    super.didUpdateWidget(oldWidget);
  }

  void updateText() {
    // ignore: unnecessary_null_comparison
    if (widget.text == null) {
      firstDesc = secondDesc = '';
    } else if (widget.text.length > widget.limitCharacter) {
      firstDesc = widget.text.substring(0, widget.limitCharacter);
      secondDesc =
          widget.text.substring(widget.limitCharacter, widget.text.length);
    } else {
      firstDesc = widget.text;
      secondDesc = '';
    }
  }

  Widget _collapseDescription(String content) {
    return Column(
      children: <Widget>[
        _text(content, Colors.black),
        Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(
                    () {
                      isShowLess = !isShowLess;
                    },
                  );
                },
                child: Text(
                  isShowLess ? 'Xem thêm' : 'Thu gọn',
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      child: secondDesc.isEmpty
          ? _text(firstDesc, Colors.black)
          : _collapseDescription(
              isShowLess ? '$firstDesc...' : firstDesc + secondDesc,
            ),
    );
  }
}
