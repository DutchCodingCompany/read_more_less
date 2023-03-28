import 'package:flutter/material.dart';

import 'expandable_text.dart';

class ReadMoreLess extends StatelessWidget {
  const ReadMoreLess({
    Key? key,
    required this.text,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.collapsedHeight = 70,
    this.maxLines = 4,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.iconCollapsed,
    this.iconExpanded,
    this.iconColor = Colors.black,
    this.buttonTextStyle,
  }) : super(key: key);

  /// The main text to be displayed.
  final String text;

  /// The text on the button when the text is expanded, in case the text overflows
  final String? readLessText;

  /// The text on the button when the text is collapsed, in case the text overflows
  final String? readMoreText;

  /// The duration of the animation when transitioning between read more and read less.
  final Duration animationDuration;

  /// The height of the [text] in the collapsed state.
  final double collapsedHeight;

  /// The maximum number of lines of the [text] in the collapsed state.
  final int maxLines;

  /// The main textstyle used for [text]
  final TextStyle? textStyle;

  /// Whether and how to align [text] horizontally.
  final TextAlign textAlign;

  /// Allows a widget to replace the icon in the read more/less button in the collapsed state.
  final Widget? iconCollapsed;

  /// Allows a widget to replace the icon in the read more/less button in the expanded state.
  final Widget? iconExpanded;

  /// The color of the icon in the read more/less button. Does not work when [iconCollapsed] or [iconExpanded] are specified.
  final Color iconColor;

  /// The textstyle used for the read more/less button
  final TextStyle? buttonTextStyle;

  bool exceedsMaxLines(BuildContext context, BoxConstraints size) {
    final span = TextSpan(
      text: text,
      style: textStyle ??
          Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
    );

    final tp = TextPainter(
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      text: span,
    );

    tp.layout(maxWidth: size.maxWidth);

    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, size) {
            return exceedsMaxLines(context, size)
                ? ExpandableText(
                    text: text,
                    animationDuration: animationDuration,
                    collapsedHeight: collapsedHeight,
                    readLessText: readLessText,
                    readMoreText: readMoreText,
                    textAlign: textAlign,
                    textStyle: textStyle,
                    iconCollapsed: iconCollapsed,
                    iconExpanded: iconExpanded,
                    iconColor: iconColor,
                    buttonTextStyle: buttonTextStyle,
                  )
                : Text(text,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: textAlign,
                    style: textStyle ?? Theme.of(context).textTheme.titleMedium);
          },
        ),
      ],
    );
  }
}
