import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';

class SearchControllerCustom extends GetxController {
  Future<List<PropertyModel>> performSearch({
    String? city,
    RangeValues? priceRange,
    RangeValues? bedroomsRange,
    RangeValues? bathroomsRange,
    RangeValues? kitchenRange,
    RangeValues? sizeRange,
    RangeValues? hallRange,
    String? searchText,
  }) async {
    CollectionReference propertiesCollection =
        FirebaseFirestore.instance.collection('property');

    try {
      // Create a list to store the results from different queries
      List<PropertyModel> searchResults = [];

      // Perform the main query based on the search text
      Query mainQuery = propertiesCollection;
      if (searchText != null) {
        // Convert the search text to lowercase for case-insensitive search
        String searchTextLower = searchText.toLowerCase();

        // Get the length of the search text for generating endAt text
        int searchTextLength = searchText.length;

        // Convert the search text to a range for partial string matching
        String startAtText = searchTextLower;
        String endAtText = searchTextLower.substring(0, searchTextLength - 1) +
            String.fromCharCode(
                searchTextLower.codeUnitAt(searchTextLength - 1) + 1);

        // Add the inequality filters for 'address' field
        mainQuery = mainQuery
            .where('address', isGreaterThanOrEqualTo: startAtText)
            .where('address', isLessThan: endAtText);
      }

      // Perform the main query and add the results to the searchResults list
      QuerySnapshot mainSnapshot = await mainQuery.get();
      searchResults.addAll(mainSnapshot.docs.map((documentSnapshot) =>
          PropertyModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>)));

      // Perform the other queries based on the range filters (price, bedrooms, bathrooms, size, hall)
      Query rangeQuery = propertiesCollection;

      if (priceRange != null) {
        rangeQuery = rangeQuery.where('price',
            isGreaterThanOrEqualTo: priceRange.start.toInt(),
            isLessThanOrEqualTo: priceRange.end.toInt());
      }
      if (city != null) {
        rangeQuery = rangeQuery.where('city', isEqualTo: city);
      }

      if (bedroomsRange != null) {
        rangeQuery = rangeQuery.where('bedrooms',
            isGreaterThanOrEqualTo: bedroomsRange.start.toInt(),
            isLessThanOrEqualTo: bedroomsRange.end.toInt());
      }
      if (bathroomsRange != null) {
        rangeQuery = rangeQuery.where('bathrooms',
            isGreaterThanOrEqualTo: bathroomsRange.start.toInt(),
            isLessThanOrEqualTo: bathroomsRange.end.toInt());
      }
      if (sizeRange != null) {
        rangeQuery = rangeQuery.where('size',
            isGreaterThanOrEqualTo: sizeRange.start.toInt(),
            isLessThanOrEqualTo: sizeRange.end.toInt());
      }
      if (hallRange != null) {
        rangeQuery = rangeQuery.where('hall',
            isGreaterThanOrEqualTo: hallRange.start.toInt(),
            isLessThanOrEqualTo: hallRange.end.toInt());
      }

      // Perform the range query and add the results to the searchResults list
      QuerySnapshot rangeSnapshot = await rangeQuery.get();
      searchResults.addAll(rangeSnapshot.docs.map((documentSnapshot) =>
          PropertyModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>)));

      // Remove duplicates if the same document is returned from both queries
      searchResults = searchResults.toSet().toList();

      return searchResults;
    } catch (e) {
      print('Error searching properties: $e');
      return [];
    }
  }
}
