import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/image_components.dart';

void main() {
  group('PropertyImageView', () {
    final testProperty = PropertyModel(
      address: 'Test Address',
      city: 'Cairo',
      propertyType: 'Apartment',
    );

    testWidgets('renders image with placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PropertyImageView(
              imageUrl: 'https://example.com/test.jpg',
              property: testProperty,
            ),
          ),
        ),
      );

      expect(find.byType(PropertyImageView), findsOneWidget);
    });

    testWidgets('tapping image navigates to full screen view', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PropertyImageView(
              imageUrl: 'https://example.com/test.jpg',
              property: testProperty,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(FullScreenImageView), findsOneWidget);
    });

    testWidgets('displays rounded container', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 300,
              child: PropertyImageView(
                imageUrl: 'https://example.com/test.jpg',
                property: testProperty,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ClipRRect), findsOneWidget);
    });
  });

  group('FullScreenImageView', () {
    testWidgets('renders full screen image viewer', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenImageView(
            imageUrl: 'https://example.com/test.jpg',
            property: PropertyModel(address: 'Test'),
          ),
        ),
      );

      expect(find.byType(FullScreenImageView), findsOneWidget);
      expect(find.byType(PhotoView), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('has back button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenImageView(
            imageUrl: 'https://example.com/test.jpg',
            property: PropertyModel(address: 'Test'),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('back button navigates back', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FullScreenImageView(
              imageUrl: 'https://example.com/test.jpg',
              property: PropertyModel(address: 'Test'),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pump();

      expect(find.byType(FullScreenImageView), findsNothing);
    });

    testWidgets('displays black background', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FullScreenImageView(
            imageUrl: 'https://example.com/test.jpg',
            property: PropertyModel(address: 'Test'),
          ),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, Colors.black);
    });
  });
}
