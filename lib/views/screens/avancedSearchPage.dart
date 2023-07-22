import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haider/models/used/propertyModel.dart';

class PropertySearchPage extends StatefulWidget {
  @override
  _PropertySearchPageState createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends State<PropertySearchPage> {
  String? city;
  RangeValues priceRange = RangeValues(0, 1000000);
  RangeValues bedroomsRange = RangeValues(0, 10);
  bool isFavoriteOnly = false;

  List<PropertyModel> properties = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Advanced UI elements for search criteria
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Filter Properties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: city,
                      items: ['City 1', 'City 2', 'City 3']
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Price Range',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RangeSlider(
                      values: priceRange,
                      min: 0,
                      max: 1000000,
                      divisions: 100,
                      onChanged: (RangeValues values) {
                        setState(() {
                          priceRange = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${priceRange.start.toInt()}'),
                        Text('\$${priceRange.end.toInt()}'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Bedrooms',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RangeSlider(
                      values: bedroomsRange,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      onChanged: (RangeValues values) {
                        setState(() {
                          bedroomsRange = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${bedroomsRange.start.toInt()} Bedrooms'),
                        Text('${bedroomsRange.end.toInt()} Bedrooms'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Favorites only'),
                        Switch(
                          value: isFavoriteOnly,
                          onChanged: (value) {
                            setState(() {
                              isFavoriteOnly = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Call the search function to retrieve properties
                        searchProperties();
                      },
                      child: Text('Search'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Show property details page on tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetailsPage(
                            property: properties[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              properties[index].address ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Display other relevant property information
                            Text('Price: \$${properties[index].price}'),
                            Text('Bedrooms: ${properties[index].bedrooms}'),
                            // You can show an icon if it's a favorite property, etc.
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to perform the search and update the properties list
  Future<void> searchProperties() async {
    // Perform the search based on the selected criteria and update the 'properties' list
    List<PropertyModel> searchResults = await _performSearch();
    setState(() {
      properties = searchResults;
    });
  }

  Future<List<PropertyModel>> _performSearch() async {
    CollectionReference propertiesCollection =
        FirebaseFirestore.instance.collection('properties');

    try {
      // Build the query based on the search parameters
      Query query = propertiesCollection;
      if (city != null) {
        query = query.where('city', isEqualTo: city);
      }
      if (isFavoriteOnly) {
        // You can retrieve favorites from Hive or Firebase based on the user
        // and then filter properties here
      }
      // Additional filter for price
      query = query.where('price', isGreaterThanOrEqualTo: priceRange.start);
      query = query.where('price', isLessThanOrEqualTo: priceRange.end);

      // Execute the query
      QuerySnapshot querySnapshot = await query.get();

      // Convert the query snapshot to a list of PropertyModel objects
      List<PropertyModel> searchResults = querySnapshot.docs
          .map((documentSnapshot) => PropertyModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>))
          .toList();

      // Perform the 'bedrooms' filter on the client-side
      searchResults = searchResults
          .where((property) =>
              int.parse(property.bedrooms!) >= bedroomsRange.start &&
              int.parse(property.bedrooms!) <= bedroomsRange.end)
          .toList();

      return searchResults;
    } catch (e) {
      print('Error searching properties: $e');
      return [];
    }
  }
}

// Property details page
class PropertyDetailsPage extends StatelessWidget {
  final PropertyModel property;

  PropertyDetailsPage({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display property details, images, description, etc.
            // You can use ListView, GridView, or any other layout as per your design.
            Text(property.address ?? ''),
            // Display other property details
          ],
        ),
      ),
    );
  }
}
