import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/fab.dart';
import 'package:haider/views/used/info.dart';

import '../compunants/rentviewcard.dart';
import '../screens/avancedSearchPage.dart';
import '../screens/google_signin_page.dart';

class HomePage extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());
  // var user = FirebaseAuth.instance.currentUser!;
  TextEditingController textController = TextEditingController();
  // void _showUserPropertiesDialog(BuildContext context, User user) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Column(
  //           children: [
  //             CircleAvatar(
  //               radius: 40,
  //               backgroundImage: user.photoURL != null
  //                   ? NetworkImage(user.photoURL!)
  //                   : NetworkImage("https://unsplash.com/photos/C8Ta0gwPbQg"),
  //             ),
  //             SizedBox(height: 8),
  //             Text(
  //               user.displayName ?? 'N/A',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //             ),
  //           ],
  //         ),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text('الايميل :${user.email ?? 'N/A'} '),
  //             SizedBox(height: 8),
  //             Text(
  //                 'الهاتف  :${GetStorage().read("phone") ?? '${user.phoneNumber} '} '),
  //           ],
  //         ),
  //         actions: [
  //           Center(
  //             child: TextButton(
  //               onPressed: () {
  //                 // Add logout functionality here
  //                 _logoutUser(context);
  //               },
  //               child: Text('تسجيل الخروج '),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _logoutUser(BuildContext context) async {
    try {
      // Perform the sign-out operation
      await FirebaseAuth.instance.signOut();
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      GetStorage().remove('name');
      GetStorage().remove('phone');
      Get.off(() => GoogleLoginScreen()); // Close the user properties dialog
      // You can navigate to the login screen or any other screen after logout.
      // For example:
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      // Handle any errors that may occur during sign-out
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Hero(
            tag: 'advancedSearchText',
            child: Material(
                type: MaterialType.transparency,
                child: SearchButton(
                  text: "البحث",
                  icon: Icons.location_city_sharp,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PropertySearchPage()));
                  },
                )),
          ),
          body: Obx(() {
            if (rentAndRentOutController.isLoading == true) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (rentAndRentOutController.allRentList.value.length == 0) {
                return Center(
                  child: Text(
                    "لم تضف عقارات بعد ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
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
                                  backgroundImage:
                                      AssetImage("assets/services.png")),
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
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                        ),
                        items: rentAndRentOutController.allRentList
                            .map((property) {
                          return Builder(
                            builder: (BuildContext context) {
                              return RealViewCard(
                                property: property,
                              );
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
                          return SizedBox(
                            height: 300,
                            child: RealViewCard(
                              property: PropertyModel.fromMap(snapshot.data()),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
                );
              }
            }
          })),
    );
  }
}
