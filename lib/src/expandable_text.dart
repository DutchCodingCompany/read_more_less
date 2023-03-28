import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    required this.text,
    Key? key,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.collapsedHeight = 70,
    this.textStyle,
    this.iconCollapsed,
    this.iconExpanded,
    this.textAlign = TextAlign.center,
    this.iconColor = Colors.black,
    this.buttonTextStyle,
  }) : super(key: key);

  final String text;
  final String? readLessText;
  final String? readMoreText;
  final Duration animationDuration;
  final double collapsedHeight;
  final TextStyle? textStyle;
  final Widget? iconExpanded;
  final Widget? iconCollapsed;
  final TextAlign textAlign;
  final Color iconColor;
  final TextStyle? buttonTextStyle;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  void _toggleExpand() {
    setState(() {
      _crossFadeState =
          _crossFadeState == CrossFadeState.showSecond ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedCrossFade(
          duration: widget.animationDuration,
          firstChild: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.collapsedHeight),
            child: Text(
              widget.text,
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: widget.textAlign,
              style: widget.textStyle ?? Theme.of(context).textTheme.titleMedium,
            ),
          ),
          secondChild: Text(
            widget.text,
            softWrap: true,
            overflow: TextOverflow.fade,
            textAlign: widget.textAlign,
            style: widget.textStyle ?? Theme.of(context).textTheme.titleMedium,
          ),
          crossFadeState: _crossFadeState,
        ),
        _crossFadeState == CrossFadeState.showSecond
            ? ConstrainedBox(
                constraints: const BoxConstraints(),
                child: TextButton.icon(
                  icon: Text(
                    widget.readLessText ?? 'Read less',
                    style: widget.buttonTextStyle ?? Theme.of(context).textTheme.titleMedium,
                  ),
                  label: widget.iconExpanded ??
                      Icon(
                        Icons.arrow_drop_up,
                        color: widget.iconColor,
                      ),
                  onPressed: _toggleExpand,
                ),
              )
            : TextButton.icon(
                icon: Text(
                  widget.readMoreText ?? 'Read more',
                  style: widget.buttonTextStyle ?? Theme.of(context).textTheme.titleMedium,
                ),
                label: widget.iconCollapsed ??
                    Icon(
                      Icons.arrow_drop_down,
                      color: widget.iconColor,
                    ),
                onPressed: _toggleExpand,
              )
      ],
    );
  }
}
