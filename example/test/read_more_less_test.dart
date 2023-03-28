// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_more_less/read_more_less.dart';

void main() {
  group('ReadMoreLess default Widget ', () {
    const String content = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et lobortis erat. Sed vulputate elit lacinia justo tincidunt varius. Nam convallis semper magna, a volutpat turpis feugiat sed. Morbi ac ligula suscipit, lobortis arcu at, ornare justo. Maecenas vestibulum, eros et imperdiet egestas, tellus enim porttitor risus, sit amet tincidunt est neque nec arcu. Pellentesque egestas dolor vitae nisl varius, ut hendrerit nisl auctor. Morbi eget ex sapien. Donec congue sagittis ante, ac fermentum felis molestie at. Integer pharetra nec est at blandit. Nullam vestibulum at est id sollicitudin. Etiam maximus ipsum orci, nec placerat ligula pharetra vel. Curabitur rutrum justo et mauris eleifend, in tristique dolor molestie. Nullam ut sem quis orci dictum vestibulum eu ac sem. Nam eu consectetur lacus. Nulla ut elit sed urna condimentum efficitur.
''';
    SizedBox defaultWidget = const SizedBox(
      width: 600,
      height: 1000,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ReadMoreLess(
          text: content,
        ),
      ),
    );

    testWidgets('changes text when expanded and collapsed', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(defaultWidget);

      // Verify that our expand text starts at 'Read more'.
      expect(find.text('Read more'), findsOneWidget);
      expect(find.text('Read less'), findsNothing);

      // Tap the 'Read more' icon and trigger a frame.
      await tester.tap(find.text('Read more'));
      await tester.pump();

      // Verify that our expand text has changed
      expect(find.text('Read less'), findsOneWidget);
      expect(find.text('Read more'), findsNothing);

      // Tap the 'Read less' icon and trigger a frame.
      await tester.tap(find.text('Read less'));
      await tester.pump();

      // Verify that our expand text has changed
      expect(find.text('Read more'), findsOneWidget);
      expect(find.text('Read less'), findsNothing);
    });

    testWidgets('can have custom read more or less text', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const SizedBox(
          width: 600,
          height: 1000,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ReadMoreLess(
              maxHeight: 20,
              text: content,
              readMoreText: 'I want to read more!',
              readLessText: 'This is enough, read less',
            ),
          ),
        ),
      );

      // Verify that our expand text starts at 'Read more'.
      expect(find.text('Read more'), findsNothing);
      expect(find.text('Read less'), findsNothing);
      expect(find.text('I want to read more!'), findsOneWidget);
      expect(find.text('This is enough, read less'), findsNothing);

      // Tap the 'Read more' icon and trigger a frame.
      await tester.tap(find.text('I want to read more!'));
      await tester.pump();

      // Verify that our expand text has changed
      expect(find.text('Read more'), findsNothing);
      expect(find.text('Read less'), findsNothing);
      expect(find.text('I want to read more!'), findsNothing);
      expect(find.text('This is enough, read less'), findsOneWidget);

      // Tap the 'Read less' icon and trigger a frame.
      await tester.tap(find.text('This is enough, read less'));
      await tester.pump();

      // Verify that our expand text has changed
      expect(find.text('Read more'), findsNothing);
      expect(find.text('Read less'), findsNothing);
      expect(find.text('I want to read more!'), findsOneWidget);
      expect(find.text('This is enough, read less'), findsNothing);
    });

    testWidgets('ReadMoreLess Widget changes size when expanded and collapsed', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        defaultWidget,
      );

      // get the second text with content (the first one is hidden by the crossfade)
      expect(tester.getSize(find.text(content).at(1)).height, equals(70.0));

      // Tap the 'Read more' icon and trigger a frame.
      await tester.tap(find.text('Read more'));
      await tester.pump();

      expect(tester.getSize(find.text(content).at(1)).height, equals(304.0));

      await tester.tap(find.text('Read less'));
      await tester.pump();

      expect(tester.getSize(find.text(content).at(1)).height, equals(70.0));
    });

    testWidgets('ReadMoreLess Widget base size changes based on maxSize provided', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const SizedBox(
          width: 600,
          height: 1000,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ReadMoreLess(
              maxHeight: 20,
              text: content,
            ),
          ),
        ),
      );

      // get the second text with content (the first one is hidden by the crossfade)
      expect(tester.getSize(find.text(content).at(1)).height, equals(20.0));

      // Tap the 'Read more' icon and trigger a frame.
      await tester.tap(find.text('Read more'));
      await tester.pump();

      expect(tester.getSize(find.text(content).at(1)).height, equals(304.0));

      await tester.tap(find.text('Read less'));
      await tester.pump();

      expect(tester.getSize(find.text(content).at(1)).height, equals(20.0));
    });
  });

  group('ReadMoreLess widget with not a lot of text ', () {
    const String content = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et lobortis erat. Sed vulputate elit lacinia justo tincidunt varius. Nam convallis semper magna''';
    SizedBox defaultWidget = const SizedBox(
      width: 600,
      height: 1000,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ReadMoreLess(
          text: content,
        ),
      ),
    );

    testWidgets('expanding is not necessary', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(defaultWidget);

      // Verify that expanding is not necessary
      expect(find.text('Read more'), findsNothing);
      expect(find.text('Read less'), findsNothing);
    });

    testWidgets('expanding is nessecary when exceeding maxLines', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const SizedBox(
          width: 600,
          height: 1000,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ReadMoreLess(
              maxHeight: 30,
              maxLines: 2,
              text: content,
            ),
          ),
        ),
      );

      // Verify that expanding is not necessary
      expect(find.text('Read more'), findsOneWidget);
      expect(find.text('Read less'), findsNothing);
    });
  });

  group('ReadMoreLess widget with custom icons ', () {
    const String content = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et lobortis erat. Sed vulputate elit lacinia justo tincidunt varius. Nam convallis semper magna''';
    SizedBox defaultWidget = const SizedBox(
      width: 600,
      height: 1000,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ReadMoreLess(
          maxHeight: 30,
          maxLines: 2,
          text: content,
          iconCollapsed: Text('Collapsed'),
          iconExpanded: Text('Expanded'),
        ),
      ),
    );

    testWidgets('shows custom collapsed and expanded widgets', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(defaultWidget);

      expect(find.text('Collapsed'), findsOneWidget);
      expect(find.text('Expanded'), findsNothing);

      // Tap the custom widget and trigger a frame.
      await tester.tap(find.text('Collapsed'));
      await tester.pump();

      expect(find.text('Expanded'), findsOneWidget);
      expect(find.text('Collapsed'), findsNothing);

      // Tap the custom widget and trigger a frame.
      await tester.tap(find.text('Expanded'));
      await tester.pump();

      expect(find.text('Collapsed'), findsOneWidget);
      expect(find.text('Expanded'), findsNothing);
    });
  });
}
