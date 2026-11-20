/// Central route map for Eskan.
///
/// Kept explicit so the refreshed search affordance and any future deep links
/// can navigate to named pages instead of building routes ad hoc in multiple
/// places. This file only registers routes; it does not change any existing
/// navigation behavior.
library routes;

import 'package:flutter/material.dart';

import 'views/screens/homeView.dart';
import 'views/screens/propertyDetailScreen.dart';
import 'views/screens/avancedSearchPage.dart';
import 'views/screens/search_results.dart';

/// Route names used by the app.
abstract final class RouteNames {
  /// Home / bottom-navigation shell.
  static const String home = '/';

  /// Advanced search entry point.
  static const String search = '/search';

  /// Search results after a query.
  static const String searchResults = '/search/results';

  /// Property detail for a single listing.
  static const String propertyDetail = '/property';
}

/// Returns the page for a named route.
///
/// Kept simple on purpose. Add routes here as the app grows rather than
/// scattering push/pop logic across the UI.
Page<dynamic>? onGenerateRoute settings {
  // Avoid unused-variable warnings while keeping the signature stable for a
  // future GetX / GoRouter integration.
  return null;
}

/// Builds a route for the property detail screen from a pushed [arguments]
/// bundle that contains a [PropertyModel].
MaterialPageRoute propertyDetailRoute(dynamic arguments) {
  final property = arguments as PropertyModel;
  return MaterialPageRoute(
    builder: (context) => PropertyDetailScreen(property: property),
  );
}

/// Convenience builders for the two search-related screens.
MaterialPageRoute searchRoute() {
  return const MaterialPageRoute(builder: (_) => PropertySearchPage());
}

MaterialPageRoute searchResultsRoute(List<dynamic> properties) {
  return MaterialPageRoute(
    builder: (_) => SearchResultPage(propertyModelList: properties),
  );
}
