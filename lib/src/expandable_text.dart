import 'package:flutter/material.dart';
import 'package:read_more_less/src/expandable_text_button.dart';
import 'package:read_more_less/src/html_container.dart';

/// {@template expandable_text}
/// A widget that displays a text that can be expanded or collapsed.
/// {@endtemplate}
class ExpandableText extends StatefulWidget {
  /// {@macro expandable_text}
  const ExpandableText({
    required this.text,
    required this.textStyle,
    super.key,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.collapsedHeight = 70,
    this.iconCollapsed,
    this.iconExpanded,
    this.customButtonBuilder,
    this.textAlign = TextAlign.center,
    this.iconColor = Colors.black,
    this.buttonTextStyle,
  });

  /// The main text to be displayed.
  final String text;

  /// The text to be displayed on the readless button.
  final String? readLessText;

  /// The text to be displayed on the readmore button.
  final String? readMoreText;

  /// The duration of the animation when transitioning between read more
  /// and less.
  final Duration animationDuration;

  /// The height of the [text] in the collapsed state.
  final double collapsedHeight;

  /// The text style of the [text].
  final TextStyle textStyle;

  /// The icon to be displayed when the text is expanded.
  final Widget? iconExpanded;

  /// The icon to be displayed when the text is collapsed.
  final Widget? iconCollapsed;

  /// A custom button builder to be used instead of the default button.
  final Widget Function(
    // Single bool parameter which seems clear to me
    // ignore: avoid_positional_boolean_parameters
    bool isCollapsed,
    VoidCallback onPressed,
  )? customButtonBuilder;

  /// The alignment of the [text].
  final TextAlign textAlign;

  /// The color of the icon.
  final Color iconColor;

  /// The text style of the button.
  final TextStyle? buttonTextStyle;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  void _toggleExpand() {
    setState(() {
      _crossFadeState = _crossFadeState == CrossFadeState.showSecond
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond;
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
            child: widget.text.isHtml
                ? HtmlContainer(content: widget.text)
                : Text(
                    widget.text,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: widget.textAlign,
                    style: widget.textStyle,
                  ),
          ),
          secondChild: widget.text.isHtml
              ? HtmlContainer(content: widget.text)
              : Text(
                  widget.text,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: widget.textAlign,
                  style: widget.textStyle,
                ),
          crossFadeState: _crossFadeState,
        ),
        if (widget.customButtonBuilder != null)
          widget.customButtonBuilder!(
            _crossFadeState == CrossFadeState.showFirst,
            _toggleExpand,
          )
        else
          ExpandableTextButton(
            expanded: _crossFadeState == CrossFadeState.showSecond,
            toggleExpand: _toggleExpand,
            readLessText: widget.readLessText,
            readMoreText: widget.readMoreText,
            iconCollapsed: widget.iconCollapsed,
            iconExpanded: widget.iconExpanded,
            iconColor: widget.iconColor,
            buttonTextStyle: widget.buttonTextStyle,
          ),
      ],
    );
  }
}
