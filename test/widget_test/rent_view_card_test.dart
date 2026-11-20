import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/favourateController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/rentviewcard.dart';
import 'package:haider/utills/app_bindings.dart';

void main() {
  setUp(() {
    Get.put(ThemeController(), permanent: true);
    Get.put(FavoritesController(), permanent: true);
    Get.put(AppBindings(), permanent: true);
  });

  tearDown(() {
    Get.reset();
  });

  group('RealViewCard', () {
    final testProperty = PropertyModel(
      address: '123 Test Street',
      city: 'Cairo',
      area: 'Maadi',
      size: '150',
      bedrooms: '3',
      bathrooms: '2',
      price: '5000',
      propertyFor: 'rent',
      propertyType: 'Apartment',
      currentUserId: 'user123',
      images: ['https://example.com/test.jpg'],
    );

    testWidgets('renders property card', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.byType(RealViewCard), findsOneWidget);
      expect(find.text('123 Test Street'), findsOneWidget);
      expect(find.text('Cairo'), findsOneWidget);
    });

    testWidgets('displays price', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.text('5000جنيه'), findsOneWidget);
    });

    testWidgets('displays bedroom count', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.text('3 غرف نوم'), findsOneWidget);
    });

    testWidgets('displays bathroom count', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.text('2 حمام'), findsOneWidget);
    });

    testWidgets('displays size', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.text('150 متر '), findsOneWidget);
    });

    testWidgets('displays property type badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.text('Apartment'), findsOneWidget);
    });

    testWidgets('displays area badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.text('Maadi'), findsOneWidget);
    });

    testWidgets('tapping card navigates to detail screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(find.byType(PropertyDetailScreen), findsOneWidget);
    });

    testWidgets('displays favorite button', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    });

    testWidgets('favorite button toggles on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      final favoriteButton = find.byType(GestureDetector).last;
      await tester.tap(favoriteButton);
      await tester.pump();

      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    });

    testWidgets('has rounded corners with shadow', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: RealViewCard(property: testProperty),
          ),
        ),
      );

      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(BoxShadow), findsWidgets);
    });
  });
}
