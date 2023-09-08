import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/views/screens/search_results.dart';

import '../../controllers/used/citycontroller.dart';

class PropertySearchPage extends GetView {
  const PropertySearchPage();
  @override
  Widget build(BuildContext context) {
    final String? city = "";
    Query<Map<String, dynamic>>? query;
    List<Widget>? chips = Get.find<CityController>()
        .cityList
        .map((city) => InkWell(
              onTap: () async {
                query = await FirebaseFirestore.instance
                    .collection('property')
                    .where('city', isEqualTo: city.cityname);

                // Navigate to the results page
                Get.to(() => SearchResultPage(query: query!));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  label: Text(city.cityname!),
                ),
              ),
            ))
        .toList();
    return Hero(
        tag: 'advancedSearchText',
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(" البحث بالمنطقه"),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new)),
              ],
              elevation: 0.0,
            ),
            body: ListView(children: [
              Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: chips,
                    )),
              ),
            ])));
  }
}
