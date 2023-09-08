import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/fab.dart';
import 'package:haider/views/used/info.dart';

import '../compunants/rentviewcard.dart';
import '../screens/avancedSearchPage.dart';

class HomePage extends GetView {
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Hero(
          tag: 'advancedSearchText',
          child: Material(
            type: MaterialType.transparency,
            child: SearchButton(
              text: "البحث",
              icon: Icons.location_city_sharp,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PropertySearchPage(),
                  ),
                );
              },
            ),
          ),
        ),
        body: Obx(() {
          if (rentAndRentOutController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (rentAndRentOutController.allRentList.isEmpty) {
            return Center(
              child: Text(
                "جارى تحميل العقارات",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          'أهلا بكم فى اسكان',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Info());
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage("assets/services.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'عناصر مميزه',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 1,
                    ),
                    items: rentAndRentOutController.allRentList
                        .map(
                          (property) => RealViewCard(
                            property: property,
                          ),
                        )
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'مضاف حديثا',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FirestoreListView<Map<String, dynamic>>(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    addSemanticIndexes: true,
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    query: rentAndRentOutController
                        .getAllRentPropertyFirestorePagnation(),
                    itemBuilder: (context, snapshot) {
                      final property = PropertyModel.fromMap(snapshot.data());
                      return RealViewCard(
                        property: property,
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
