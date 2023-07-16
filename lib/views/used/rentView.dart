import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/unused/searchRentController.dart';
import 'package:haider/controllers/used/currentUserInfoController.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';

import '../compunants/rentviewcard.dart';
import 'propertyDetailScreen.dart';

class HomePage extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());
  final CurrentUserInfoController userInfoController =
      Get.put(CurrentUserInfoController());
  final SearchRentController searchRentController =
      Get.put(SearchRentController());
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
                    children: [
                      rentAndRentOutController.value.value == true
                          ? Column(
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
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: rentAndRentOutController
                                        .allRentList.value.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            childAspectRatio: 1.07),
                                    itemBuilder: (context, index) {
                                      var property = rentAndRentOutController
                                          .allRentList[index];
                                      return RealViewCard(property: property);
                                    }),
                              ],
                            )
                          : Obx(() {
                              if (searchRentController.isLoading.value ==
                                  true) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return searchRentController.rentSerachList.value.length ==
                                        0
                                    ? Center(
                                        child: Text(
                                        'No Data Found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.prime_color),
                                      ))
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: searchRentController
                                            .rentSerachList.value.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1100,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 3,
                                              child: InkWell(
                                                  splashColor: Colors.green,
                                                  onTap: () {
                                                    Get.to(() => PropertyDetail(
                                                        data: searchRentController
                                                                .rentSerachList[
                                                            index]));
                                                  },
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Stack(
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl: searchRentController
                                                                    .rentSerachList[
                                                                        index]
                                                                    .images![0],
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  height: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Center(
                                                                        child: Icon(
                                                                            Icons.error)),
                                                              ),
                                                              searchRentController
                                                                          .rentSerachList[
                                                                              index]
                                                                          .action ==
                                                                      'Sold Out'
                                                                  ? Positioned(
                                                                      top: 5,
                                                                      left: 5,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                CustomColors.prime_color,
                                                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Sold Out',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : Container(
                                                                      height: 0,
                                                                      width: 0,
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            searchRentController
                                                                .rentSerachList[
                                                                    index]
                                                                .address!,
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            '${searchRentController.rentSerachList[index].city![0].toUpperCase()}${searchRentController.rentSerachList[index].city!.substring(1).toLowerCase()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Row(
                                                            //  mainAxisAlignment:
                                                            //   MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Text(
                                                                'Price',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                '${searchRentController.rentSerachList[index].price} Rs',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: CustomColors
                                                                        .prime_color),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ])));
                                        });
                              }
                            })
                    ],
                  ),
                ),
              );
      }
    }));
  }
}
