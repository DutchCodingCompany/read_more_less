import 'package:flutter/material.dart';

/// {@template expandable_text_button}
/// A widget that displays a text button that can be expanded or collapsed.
/// {@endtemplate}
class ExpandableTextButton extends StatelessWidget {
  /// {@macro expandable_text_button}
  const ExpandableTextButton({
    required this.expanded,
    required this.toggleExpand,
    this.readLessText,
    this.readMoreText,
    this.buttonTextStyle,
    this.iconExpanded,
    this.iconCollapsed,
    this.iconColor,
    super.key,
  });

  /// Whether the button is expanded or not.
  final bool expanded;

  /// A callback to toggle the button.
  final VoidCallback toggleExpand;

  /// The text to be displayed on the readless button.
  final String? readLessText;

  /// The text to be displayed on the readmore button.
  final String? readMoreText;

  /// The text style of the button.
  final TextStyle? buttonTextStyle;

  /// The icon to be displayed when the button is expanded.
  final Widget? iconExpanded;

  /// The icon to be displayed when the button is collapsed.
  final Widget? iconCollapsed;

  /// The color of the icon.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return expanded
        ? ConstrainedBox(
            constraints: const BoxConstraints(),
            child: TextButton.icon(
              icon: Text(
                readLessText ?? 'Read less',
                style: buttonTextStyle,
              ),
              label: iconExpanded ??
                  Icon(
                    Icons.arrow_drop_up,
                    color: iconColor,
                  ),
              onPressed: toggleExpand,
            ),
          )
        : TextButton.icon(
            icon: Text(
              readMoreText ?? 'Read more',
              style: buttonTextStyle,
            ),
            label: iconCollapsed ??
                Icon(
                  Icons.arrow_drop_down,
                  color: iconColor,
                ),
            onPressed: toggleExpand,
          );
  }
}
