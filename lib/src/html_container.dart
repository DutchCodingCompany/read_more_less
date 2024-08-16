import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

/// {@template html_container}
/// A widget that displays HTML content.
/// {@endtemplate}
class HtmlContainer extends StatelessWidget {
  /// {@macro html_container}
  const HtmlContainer({required this.content, super.key});

  /// The String HTML content to be displayed.
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: {
        //These body elements are added to prevent the HTML from adding spacings
        // to it.
        //The 'body' tag sets the horizontal padding and margin to zero.
        //The 'body > *:(first/last)-child' will set the top/bottom padding to zero,
        //so the first and last body field won't add spacings on the top/bottom
        'body': Style(padding: HtmlPaddings.zero, margin: Margins.zero),
        'body > *:first-child': Style(
          padding: HtmlPaddings.zero,
          margin: Margins(
            top: Margin.zero(),
          ),
        ),
        'body > *:last-child': Style(
          padding: HtmlPaddings.zero,
          margin: Margins(
            bottom: Margin.zero(),
          ),
        ),
      },
    );
  }
}

/// Extension for [String] to determine if the string is HTML
extension HTMLRecognizer on String {
  /// Returns `true` if the string is HTML
  bool get isHtml {
    final htmlRegex = RegExp(r'<\s*([^ >]+)[^>]*>.*?<\s*/\s*\1\s*>');
    return htmlRegex.hasMatch(this);
  }
}
