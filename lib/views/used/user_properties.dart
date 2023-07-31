import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';

import '../../controllers/unused/getSellAndBuyPropertController.dart';
import '../compunants/add_information_dialog.dart';
import '../compunants/fab.dart';
import '../screens/addDataScreen.dart';
import 'currentUserPropertyDetail.dart';

class UserProperties extends StatelessWidget {
  // const RentOutView({Key key}) : super(key: key);
  final RentAndRentOutController rentOutController = Get.find();
  final GetSellAndBuyPropertyController rentOut2Controller =
      Get.put(GetSellAndBuyPropertyController());
/* CurrentUserPropertyDetail(
                                    data: rentOutController
                                        .currentUserRentOutlist[index])*/
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Hero(
          tag: 'addProperty',
          child: Material(
              type: MaterialType.transparency,
              child: SearchButton(
                icon: FontAwesomeIcons.house,
                text: "أضف عقار",
                onTap: () {
                  box.read('name') == null
                      ? showDialog(
                          context: context,
                          builder: (BuildContext context) => EnterInfoDialog(),
                        )
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddDataScreen(
                                value: '',
                              )));
                },
              )),
        ),
        body: Obx(() {
          if (rentOutController.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          } else {
            return rentOutController.currentUserRentOutlist.value.length == 0
                ? Center(
                    child: Text(
                      "لم تضف عقارات بعد",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: rentOutController
                            .currentUserRentOutlist.value.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.19,
                        ),
                        itemBuilder: (context, index) {
                          var property =
                              rentOutController.currentUserRentOutlist[index];
                          return InkWell(
                            onTap: () => Get.to(() => CurrentUserPropertyDetail(
                                property: rentOutController
                                    .currentUserRentOutlist[index])),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: property
                                          .images![0], // URL of the image
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 500,
                                      // placeholder: (context, url) =>
                                      //     CircularProgressIndicator(), // Placeholder widget while the image is loading
                                      // errorWidget: (context, url, error) =>
                                      //     Icon(Icons.error), // Widget to display in case of an error
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.7),
                                            ],
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            bottom: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              property.address!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color:
                                                      CustomColors.coral_Color,
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${property.city![0].toUpperCase()}${property.city!.substring(1).toLowerCase()}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.king_bed,
                                                        color: Colors.white,
                                                        size: 10,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${property.propertyFor} صاله',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Icon(
                                                        Icons.chair,
                                                        color: Colors.white,
                                                        size: 10,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${property.bedrooms} غرف نوم',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Icon(
                                                        Icons.bathtub,
                                                        color: Colors.white,
                                                        size: 10,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${property.bathrooms} حمام',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Icon(
                                                        Icons.aspect_ratio,
                                                        color: Colors.white,
                                                        size: 10,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${property.size} متر ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  '${property.price.toString()}جنيه',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          property.propertyType!,
                                          style: const TextStyle(
                                            color: CustomColors.coral_Color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 50,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          property.area!,
                                          style: const TextStyle(
                                            color: CustomColors.coral_Color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
          }
        }));
  }
}
