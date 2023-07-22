import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/utills/customColors.dart';

import '../compunants/rentviewcard.dart';

class HomePage extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (rentAndRentOutController.isLoading == true) {
        return Center(child: CircularProgressIndicator());
      } else {
        return rentAndRentOutController.allRentList.value.length == 0
            ? Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.prime_color),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      items:
                          rentAndRentOutController.allRentList.map((property) {
                        return Builder(
                          builder: (BuildContext context) {
                            return RealViewCard(property: property);
                          },
                        );
                      }).toList(),
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
                      pageSize: 10,
                      addSemanticIndexes: true,
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      query: rentAndRentOutController
                          .getAllRentPropertyFirestorePagnation(),
                      itemBuilder: (context, snapshot) {
                        return RealViewCard(
                            property: PropertyModel.fromMap(snapshot.data()));
                      },
                    ),
                  ],
                )),
              );
      }
    }));
  }
}
