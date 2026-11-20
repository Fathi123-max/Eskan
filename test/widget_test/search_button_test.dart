import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haider/views/compunants/fab.dart';

void main() {
  group('SearchButton', () {
    testWidgets('renders button with text and icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchButton(
              text: 'اختبار',
              icon: Icons.search,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('اختبار'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchButton(
              text: 'Search',
              icon: Icons.search,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      expect(tapped, isTrue);
    });

    testWidgets('has correct dimensions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchButton(
              text: 'Search',
              icon: Icons.search,
              onTap: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, 50);
      expect(container.constraints?.maxWidth, 150);
    });

    testWidgets('has white background with rounded corners', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchButton(
              text: 'Search',
              icon: Icons.search,
              onTap: () {},
            ),
          ),
        ),
      );

      final decoration = tester.widget<Container>(find.byType(Container)).decoration
          as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(30));
    });

    testWidgets('icon and text have blue color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchButton(
              text: 'Search',
              icon: Icons.search,
              onTap: () {},
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.search));
      expect(icon.color, Colors.blue);

      final text = tester.widget<Text>(find.text('Search'));
      expect(text.style?.color, Colors.blue);
    });
  });
}
