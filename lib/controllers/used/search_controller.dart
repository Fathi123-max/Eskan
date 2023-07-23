import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';

class SearchControllerCustom extends GetxController {
  Future<List<PropertyModel>> performSearch(
      {String? city,
      RangeValues? priceRange,
      RangeValues? bedroomsRange,
      RangeValues? bathroomsRange,
      RangeValues? kitchenRange,
      RangeValues? sizeRange,
      RangeValues? hallRange,
      String? searchText}) async {
    CollectionReference propertiesCollection =
        FirebaseFirestore.instance.collection('property');

    try {
      // Build the query based on the search parameters
      Query query = propertiesCollection;
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

        // Perform the query
        query = query
            .where('address', isGreaterThanOrEqualTo: startAtText)
            .where('address', isLessThan: endAtText);
      }

      if (city != null) {
        query = query.where('city', isEqualTo: city);
      }
      if (priceRange != null) {
        query = query.where('price', isGreaterThanOrEqualTo: priceRange.start);
        query = query.where('price', isLessThanOrEqualTo: priceRange.end);
      }

      if (bathroomsRange != null) {
        query =
            query.where('price', isGreaterThanOrEqualTo: bathroomsRange.start);
        query = query.where('price', isLessThanOrEqualTo: bathroomsRange.end);
      }

      if (bedroomsRange != null) {
        query =
            query.where('price', isGreaterThanOrEqualTo: bedroomsRange.start);
        query = query.where('price', isLessThanOrEqualTo: bedroomsRange.end);
      }

      if (sizeRange != null) {
        query = query.where('price', isGreaterThanOrEqualTo: sizeRange.start);
        query = query.where('price', isLessThanOrEqualTo: sizeRange.end);
      }
      if (hallRange != null) {
        query = query.where('price', isGreaterThanOrEqualTo: hallRange.start);
        query = query.where('price', isLessThanOrEqualTo: hallRange.end);
      }

      QuerySnapshot querySnapshot = await query.get();

      // Convert the query snapshot to a list of PropertyModel objects
      List<PropertyModel> searchResults = querySnapshot.docs
          .map((documentSnapshot) => PropertyModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>))
          .toList();

      // Perform the 'bedrooms' filter on the client-side

      return searchResults;
    } catch (e) {
      print('Error searching properties: $e');
      return [];
    }
  }
}
