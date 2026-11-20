import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:haider/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Eskan App E2E Tests', () {
    testWidgets('app launches with home page', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // App should display the home view
      expect(find.byType(Home), findsOneWidget);
    });

    testWidgets('bottom navigation shows three tabs', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify bottom navigation bar is present
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify three navigation items
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('المفضله'), findsOneWidget);
      expect(find.text('My Services'), findsOneWidget);
    });

    testWidgets('can navigate between tabs', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Tap on the second tab (Favorites)
      await tester.tap(find.text('المفضله'));
      await tester.pumpAndSettle();

      // Tap on the third tab (My Services)
      await tester.tap(find.text('My Services'));
      await tester.pumpAndSettle();

      // Return to home tab
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
