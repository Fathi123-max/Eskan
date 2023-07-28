import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/views/screens/search_results.dart';

import '../../controllers/used/citycontroller.dart';
import '../../controllers/used/search_controller.dart';

class PropertySearchPage extends StatefulWidget {
  @override
  _PropertySearchPageState createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends State<PropertySearchPage> {
  String? city;
  RangeValues priceRange = RangeValues(0, 10000);
  RangeValues bedroomsRange = RangeValues(0, 10);
  RangeValues bathroomsRange = RangeValues(0, 10);
  RangeValues kitchenRange = RangeValues(0, 10);
  RangeValues sizeRange = RangeValues(0, 1000);
  RangeValues hallRange = RangeValues(0, 10);
  bool isFavoriteOnly = false;
  SearchController searchController = SearchController();

  List<PropertyModel> properties = [];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>>? drop = Get.find<CityController>()
        .cityList
        .map((city) => DropdownMenuItem(
              value: city.cityname,
              child: Text(city.cityname!),
            ))
        .toList();
    return Hero(
        tag: 'advancedSearchText',
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("البحث"),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new)),
              ],
              elevation: 0.0,
            ),
            body: ListView(children: [
              // Advanced UI elements for search criteria
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                    hintText: "أدخل عنوان العقار ",
                    controller: searchController,
                    trailing: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      )
                    ]),
              ),

              Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'الفلاتر ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: city,
                        hint: Text("أدخل اسم المدينه"),
                        items: drop,
                        onChanged: (value) {
                          setState(() {
                            city = value;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'السعر',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RangeSlider(
                        values: priceRange,
                        min: 0,
                        max: 10000,
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
                          Text('${priceRange.start.toInt()} جنيه'),
                          Text('${priceRange.end.toInt()} جنيه'),
                        ],
                      ),
                      // SizedBox(height: 16),
                      // Text(
                      //   'المساحه',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // RangeSlider(
                      //   values: sizeRange,
                      //   min: 0,
                      //   max: 1000,
                      //   divisions: 10,
                      //   onChanged: (RangeValues values) {
                      //     setState(() {
                      //       sizeRange = values;
                      //     });
                      //   },
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('${sizeRange.start.toInt()} متر'),
                      //     Text('${sizeRange.end.toInt()} متر'),
                      //   ],
                      // ),
                      // SizedBox(height: 16),
                      // Text(
                      //   'غرف نوم',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // RangeSlider(
                      //   values: bedroomsRange,
                      //   min: 0,
                      //   max: 10,
                      //   divisions: 10,
                      //   onChanged: (RangeValues values) {
                      //     setState(() {
                      //       bedroomsRange = values;
                      //     });
                      //   },
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('${bedroomsRange.start.toInt()} غرف نوم'),
                      //     Text('${bedroomsRange.end.toInt()} غرف نوم'),
                      //   ],
                      // ),
                      // SizedBox(height: 16),
                      // Text(
                      //   'الحمامات',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // RangeSlider(
                      //   values: bathroomsRange,
                      //   min: 0,
                      //   max: 10,
                      //   divisions: 10,
                      //   onChanged: (RangeValues values) {
                      //     setState(() {
                      //       bathroomsRange = values;
                      //     });
                      //   },
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('${bathroomsRange.start.toInt()} الحمامات'),
                      //     Text('${bathroomsRange.end.toInt()} الحمامات'),
                      //   ],
                      // ),
                      // SizedBox(height: 16),
                      // Text(
                      //   'الصالات',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // RangeSlider(
                      //   values: hallRange,
                      //   min: 0,
                      //   max: 10,
                      //   divisions: 10,
                      //   onChanged: (RangeValues values) {
                      //     setState(() {
                      //       hallRange = values;
                      //     });
                      //   },
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('${hallRange.start.toInt()} الصالات'),
                      //     Text('${hallRange.end.toInt()} الصالات'),
                      //   ],
                      // ),
                      // SizedBox(height: 16),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('المفضله'),
                      //     Switch(
                      //       value: isFavoriteOnly,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           isFavoriteOnly = value;
                      //         });
                      //       },
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          // Your search function here
                          // Call the performSearch function and navigate to the results page

                          // Example:
                          List<PropertyModel> properties =
                              await Get.put(SearchControllerCustom())
                                  .performSearch(
                            // Set your filter variables here
                            city: city,
                            priceRange: priceRange,
                            searchText: searchController.text.toLowerCase(),
                            // Add more filter parameters as needed
                          );

                          // Navigate to the results page
                          Get.to(() =>
                              SearchResultPage(propertyModelList: properties));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25), // Adjust the value to control the rounding
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Search',
                            style: TextStyle(
                              color: CustomColors.green_color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //   SizedBox(height: 16),
              //   ListView.builder(
              //     itemCount: properties.length,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: () {
              //           // Show property details page on tap
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => PropertyDetailScreen(
              //                 property: properties[index],
              //               ),
              //             ),
              //           );
              //         },
              //         child: Card(
              //           elevation: 2,
              //           child: Padding(
              //             padding: EdgeInsets.all(16),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.stretch,
              //               children: [
              //                 Text(
              //                   properties[index].address ?? '',
              //                   style: TextStyle(
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 SizedBox(height: 8),
              //                 // Display other relevant property information
              //                 Text('Price: \$${properties[index].price}'),
              //                 Text('Bedrooms: ${properties[index].bedrooms}'),
              //                 // You can show an icon if it's a favorite property, etc.
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   )
            ])));
  }
}
