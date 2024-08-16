import 'package:flutter/material.dart';
import 'package:read_more_less/src/expandable_text.dart';

/// {@template read_more_less}
/// A widget that displays a text that can be expanded or collapsed.
/// {@endtemplate}
class ReadMoreLess extends StatelessWidget {
  /// {@macro read_more_less}
  const ReadMoreLess({
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
    this.customButtonBuilder,
    this.iconColor = Colors.black,
    this.buttonTextStyle,
    super.key,
  })  : assert(
          (iconCollapsed == null && iconExpanded == null) ||
              customButtonBuilder == null,
          'You cannot use custom icons while using a custom button builder',
        ),
        assert(
          buttonTextStyle == null || customButtonBuilder == null,
          'You cannot use a custom button style while using a custom '
          'button builder',
        ),
        assert(
          (readLessText == null && readMoreText == null) ||
              customButtonBuilder == null,
          'You cannot provide readLess or readMore text when using '
          'a custom button builder',
        );

  /// The main text to be displayed.
  final String text;

  /// The text on the button when the text is expanded,
  /// in case the text overflows
  final String? readLessText;

  /// The text on the button when the text is collapsed,
  /// in case the text overflows
  final String? readMoreText;

  /// The duration of the animation when transitioning between read more and
  /// read less.
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

  /// Allows for a function that builds a custom clickable widget.
  // Refers to the custom button builder in the ExpandableText widget
  // ignore: comment_references
  /// [isCollapsed] is provided to detimine in what state
  /// the widget has to be built.
  // Refers to the custom button builder in the ExpandableText widget
  // ignore: comment_references
  /// [onPressed] is provided to allow for the widget to be clickable and to
  /// trigger the collapsed state.
  final Widget Function(
    // Single bool parameter which seems clear to me
    // ignore: avoid_positional_boolean_parameters
    bool isCollapsed,
    VoidCallback onPressed,
  )? customButtonBuilder;

  /// The color of the icon in the read more/less button. Does not work when [iconCollapsed] or [iconExpanded] are specified.
  final Color iconColor;

  /// The textstyle used for the read more/less button
  final TextStyle? buttonTextStyle;

  bool _exceedsMaxLines(TextStyle textStyle, BoxConstraints size) {
    final span = TextSpan(text: text, style: textStyle);

    final tp = TextPainter(
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      text: span,
    )..layout(maxWidth: size.maxWidth);

    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final ts = textStyle ?? Theme.of(context).textTheme.bodyMedium!;

    return Column(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, size) {
            return _exceedsMaxLines(ts, size)
                ? ExpandableText(
                    text: text,
                    animationDuration: animationDuration,
                    collapsedHeight: collapsedHeight,
                    readLessText: readLessText,
                    readMoreText: readMoreText,
                    textAlign: textAlign,
                    textStyle: ts,
                    iconCollapsed: iconCollapsed,
                    iconExpanded: iconExpanded,
                    customButtonBuilder: customButtonBuilder,
                    iconColor: iconColor,
                    buttonTextStyle: buttonTextStyle,
                  )
                : Text(
                    text,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: textAlign,
                    style: ts,
                  );
          },
        ),
      ],
    );
  }
}
