import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.padding,
    this.tooltip,
    this.initiallyExpanded = true,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.collapsedBackgroundColor,
    this.showDivider = false,
    this.isDisable = false,
    this.showTitle = true,
  })  : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        ),
        super(key: key);

  final Widget? leading;

  final Widget title;

  final Widget? subtitle;

  final String? tooltip;

  final ValueChanged<bool>? onExpansionChanged;

  final List<Widget> children;

  final Color? backgroundColor;

  final Color? collapsedBackgroundColor;

  final Widget? trailing;

  final EdgeInsets? padding;

  final bool initiallyExpanded;

  final bool maintainState;

  final EdgeInsetsGeometry? tilePadding;

  final Alignment? expandedAlignment;

  final CrossAxisAlignment? expandedCrossAxisAlignment;

  final EdgeInsetsGeometry? childrenPadding;

  final bool showDivider;

  final bool isDisable;

  final bool showTitle;

  @override
  ExpansionWidgetState createState() => ExpansionWidgetState();
}

class ExpansionWidgetState extends State<ExpansionWidget>
    with SingleTickerProviderStateMixin {
  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    }
  }

  static Widget tooltip(context,
      {IconData? icon, double? iconSize, String? message}) {
    return Tooltip(
      message: message ?? '',
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(
          color: Colors.white54,
          width: 1,
        ),
      ),
      textStyle:
          Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
      preferBelow: true,
      verticalOffset: 20,
      child: Icon(
        icon ?? CupertinoIcons.info,
        size: iconSize ?? 14.0,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: _isExpanded
            ? widget.backgroundColor ?? Colors.transparent
            : widget.collapsedBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (widget.showDivider) const Divider(height: 1),
          if (widget.showTitle)
            InkWell(
              hoverColor: Colors.transparent,
              onTap: () => widget.isDisable ? {} : _handleTap(),
              child: Container(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                child: Row(
                  children: [
                    widget.title,
                    const SizedBox(width: 4),
                    widget.tooltip != null
                        ? tooltip(context, message: widget.tooltip)
                        : const SizedBox(),
                    const Spacer(),
                    // AnimatedIcon(
                    //   size: 20,
                    //   color: Theme.of(context).backgroundColor,
                    //   icon: AnimatedIcons.menu_close,
                    //   progress: _controller,
                    // ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      child: _isExpanded
                          ? Icon(
                              CupertinoIcons.minus,
                              size: 15,
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          : Icon(
                              CupertinoIcons.plus,
                              size: 15,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: _isExpanded ? child : const SizedBox(width: double.infinity),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.colorScheme.secondary;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor
      ..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final closed = !_isExpanded;
    final shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
        offstage: closed,
        child: TickerMode(
          enabled: !closed,
          child: Padding(
            padding:
                widget.childrenPadding ?? const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment:
                  widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
        ));

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
