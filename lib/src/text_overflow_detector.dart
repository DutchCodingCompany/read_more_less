import 'package:flutter/material.dart';
import 'package:read_more_less/src/expandable_text.dart';

class ReadMoreLess extends StatelessWidget {
  const ReadMoreLess({
    Key? key,
    required this.text,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.maxHeight = 70,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.iconCollapsed,
    this.iconExpanded,
    this.iconColor = Colors.black,
  }) : super(key: key);

  /// The main text to be displayed.
  final String text;

  /// The text on the button when the text is expanded, in case the text overflows
  final String? readLessText;

  /// The text on the button when the text is collapsed, in case the text overflows
  final String? readMoreText;

  /// The duration of the animation when transitioning between read more and read less.
  final Duration animationDuration;

  /// The maximum height of container around the [text] in the collapsed state.
  final double maxHeight;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, size) {
            final span = TextSpan(
              text: text,
              style: textStyle ??
                  Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).textTheme.bodyText2?.color),
            );

            final tp = TextPainter(
              maxLines: 4,
              textAlign: textAlign,
              textDirection: TextDirection.ltr,
              text: span,
            );

            tp.layout(maxWidth: size.maxWidth);

            final isExceeded = tp.didExceedMaxLines;

            return isExceeded
                ? ExpandableText(
                    text: text,
                    animationDuration: animationDuration,
                    maxHeight: maxHeight,
                    readLessText: readLessText,
                    readMoreText: readMoreText,
                    textAlign: textAlign,
                    textStyle: textStyle,
                    iconCollapsed: iconCollapsed,
                    iconExpanded: iconExpanded,
                    iconColor: iconColor,
                  )
                : Text(text,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: textAlign,
                    style: textStyle ?? Theme.of(context).textTheme.subtitle1);
          },
        ),
      ],
    );
  }
}
