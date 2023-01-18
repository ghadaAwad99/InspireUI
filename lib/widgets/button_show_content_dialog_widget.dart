import 'package:flutter/material.dart';

part 'button_show_content_dialog/button_show_content_dialog_constants.dart';

typedef BuilderDialog = Widget Function(
    BuildContext context, Function closeDialog);

class ButtonShowContentDialog extends StatefulWidget {
  final BuilderDialog dialog;
  final Widget child;
  final double widthDialog;
  final double heightDialog;
  final double borderRadiusDialog;
  final Color? colorBorderDialog;

  const ButtonShowContentDialog({
    Key? key,
    required this.dialog,
    required this.child,
    this.widthDialog = 200,
    this.heightDialog = 200,
    this.borderRadiusDialog = 10,
    this.colorBorderDialog,
  }) : super(key: key);

  @override
  ButtonShowContentDialogState createState() => ButtonShowContentDialogState();
}

class ButtonShowContentDialogState extends State<ButtonShowContentDialog> {
  OverlayEntry? _overlayEntry;
  late bool _isShowList;
  GlobalKey<ButtonShowContentDialogState>? _globalKey;

  @override
  void initState() {
    _isShowList = false;
    _globalKey = GlobalKey<ButtonShowContentDialogState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      child: _buildItem(),
    );
  }

  OverlayEntry _buildEntry() {
    // ignore: avoid_as
    final box = _globalKey!.currentContext!.findRenderObject() as RenderBox;
    final sizeWidget = box.size;

    final pos = box.localToGlobal(Offset.zero);

    var left = pos.dx;
    double? right = 0.0;
    var maxWidth = widget.widthDialog;
    var maxHeight = widget.heightDialog;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (left + widget.widthDialog > width) {
      left = 0;
      right = width - pos.dx - sizeWidget.width;
    }

    if (right + widget.widthDialog > width) {
      if (right > pos.dx) {
        right = null;
        left = pos.dx;
        final w = width - pos.dx - sizeWidget.width;
        maxWidth = w < maxWidth ? w : maxWidth;
      } else {
        final w = width - right - sizeWidget.width;
        maxWidth = w < maxWidth ? w : maxWidth;
      }
    }

    var top = pos.dy + 60;
    double? bottom = 0.0;
    if (height - top < maxHeight) {
      bottom = height - pos.dy + 10;

      if (pos.dy - 10 < maxHeight) {
        maxHeight = pos.dy - 60;
      }
      top = 0;
    } else {
      if ((height - top) < maxHeight) {
        maxHeight = height - pos.dy - 10;
      }
    }
    if (right == 0.0) {
      right = null;
    }

    if (bottom == 0.0) {
      bottom = null;
    }

    return OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: _hide,
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              top: top,
              left: left,
              right: right,
              bottom: bottom,
              child: _buildList(maxWidth, maxHeight),
            ),
          ],
        );
      },
    );
  }

  void _show() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _isShowList = true;
      _overlayEntry = _buildEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    });
  }

  void _hide() {
    _isShowList = false;
    _overlayEntry?.remove();
  }

  Widget _buildItem() {
    return ElevatedButton(
      onPressed: () {
        if (_isShowList) {
          _hide();
          setState(() {});
        } else {
          _show();
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
      ),
      child: widget.child,
    );
  }

  Widget _buildList(maxWidth, maxHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadiusDialog),
            border: Border.all(
                color: widget.colorBorderDialog ?? Colors.transparent),
          ),
          width: maxWidth,
          height: maxHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadiusDialog),
            child: widget.dialog.call(context, () {
              _hide();
              setState(() {});
            }),
          ),
        ),
      ],
    );
  }
}
