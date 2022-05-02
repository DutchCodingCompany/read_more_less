import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    required this.text,
    Key? key,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.maxHeight = 70,
    this.textStyle,
    this.iconCollapsed,
    this.iconExpanded,
    this.textAlign = TextAlign.center,
    this.iconColor = Colors.black,
  }) : super(key: key);

  final String text;
  final String? readLessText;
  final String? readMoreText;
  final Duration animationDuration;
  final double maxHeight;
  final TextStyle? textStyle;
  final Widget? iconExpanded;
  final Widget? iconCollapsed;
  final TextAlign textAlign;
  final Color iconColor;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedSize(
          duration: widget.animationDuration,
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : BoxConstraints(maxHeight: widget.maxHeight),
            child: Text(
              widget.text,
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: widget.textAlign,
              style: widget.textStyle ?? Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        isExpanded
            ? ConstrainedBox(
                constraints: const BoxConstraints(),
                child: TextButton.icon(
                  icon: Text(
                    widget.readLessText ?? 'Read less',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  label: widget.iconExpanded ??
                      Icon(
                        Icons.arrow_drop_up,
                        color: widget.iconColor,
                      ),
                  onPressed: () => setState(() => isExpanded = false),
                ),
              )
            : TextButton.icon(
                icon: Text(
                  widget.readMoreText ?? 'Read more',
                  style:
                      widget.textStyle ?? Theme.of(context).textTheme.subtitle1,
                ),
                label: widget.iconCollapsed ??
                    Icon(
                      Icons.arrow_drop_down,
                      color: widget.iconColor,
                    ),
                onPressed: () => setState(() => isExpanded = true),
              )
      ],
    );
  }
}
