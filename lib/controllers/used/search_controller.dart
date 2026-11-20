import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/used/propertyModel.dart';
import '../../services/PropertyServices.dart';

class SearchControllerCustom extends GetxController {
  final PropertyServices _service = PropertyServices();

  /// Perform a search for rental properties.
  /// 
  /// [city] — filter by city name (optional)
  /// [priceFrom] — minimum price filter (optional)
  /// [priceTo] — maximum price filter (optional)
  /// [searchText] — text to search in area names (optional)
  Future<List<PropertyModel>> performSearch({
    String? city,
    int? priceFrom,
    int? priceTo,
    String? searchText,
  }) async {
    try {
      // If searchText is provided, use area-based search
      if (searchText != null && searchText.trim().isNotEmpty) {
        return _service.searchByArea(searchText.trim());
      }

      // Otherwise use the standard property search
      return _service.searchRentList(
        cityName: city,
        priceFrom: priceFrom,
        priceTo: priceTo,
      );
    } catch (e) {
      print('Error searching properties: $e');
      return [];
    }
  }

  /// Search for properties for sale
  Future<List<PropertyModel>> searchBuy({
    String? city,
    int? priceFrom,
    int? priceTo,
  }) async {
    try {
      return _service.searchBuyList(
        cityName: city,
        priceFrom: priceFrom,
        priceTo: priceTo,
      );
    } catch (e) {
      print('Error searching buy properties: $e');
      return [];
    }
  }
}
