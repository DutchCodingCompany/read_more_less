import 'package:flutter_test/flutter_test.dart';
import 'package:read_more_less/src/html_container.dart';

void main() {
  test('Text with only a starting tag is not seen as valid HTML', () {
    expect('<testtag> bla bla'.isHtml, false);
  });

  test('Text with only a end tag is not seen as valid HTML', () {
    expect('bla bla</testtag>'.isHtml, false);
  });

  test('Text with start a end tag is seen as valid HTML', () {
    expect('<testtag>bla bla</testtag>'.isHtml, true);
  });

  test('Text with a different start and end tag is seen as invalid HTML', () {
    expect('<testtag>bla bla</othertesttag>'.isHtml, false);
  });
}
