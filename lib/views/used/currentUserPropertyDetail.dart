import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/currentUserInfoController.dart';
import 'package:haider/controllers/used/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/utills/customColors.dart';

import '../../utills/customToast.dart';
import '../../views/compunants/image_components.dart';

class CurrentUserPropertyDetail extends StatelessWidget {
  final PropertyModel property;

  CurrentUserPropertyDetail({required this.property});

  final CurrentUserInfoController controller =
      Get.find();
  final GetSellAndBuyPropertyController getSellAndBuyPropertyController =
      Get.find();
  final RentAndRentOutController rentAndRentOutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(property.address!),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new)),
          ],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    children: [
                      PageView(
                        onPageChanged: (index) {
                          controller.selectedIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                        children: property.images!.map((e) {
                          return Hero(
                            tag: e,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImageView(
                                      imageUrl: e,
                                      property: property,
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: e,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 220,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(color: Colors.grey.shade300),
                                  child: Center(child: CircularProgressIndicator()),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(color: Colors.grey.shade300),
                                  child: Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: property.images!.map((e) {
                      int index = property.images!.indexOf(e);
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: controller.selectedIndex.value == index
                                ? CustomColors.prime_color
                                : Colors.black54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
                // price
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${property.price} جنيه',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: CustomColors.prime_color),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${property.city}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //name
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.address!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),

                //descrip
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'Description'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.descr ?? "",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),

                //adress
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'address'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.area!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'نوع العقار'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.propertyType!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                // addtional informations
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'معلومات اضافيه ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.bed_outlined),
                      Text(
                        ' ${property.bedrooms} غرف نوم ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.bathtub_outlined),
                      Text(
                        ' ${property.bathrooms} حمام',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.kitchen_outlined),
                      Text(
                        ' ${property.kitchen} مطبخ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.crop_square_outlined),
                      Text(
                        ' ${property.size} متر',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.chair_outlined),
                      Text(
                        ' ${property.propertyFor} صاله',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: property.action == 'Sold Out' ||
                          property.action == 'Rented'
                      ? Obx(() {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.showLoadingBar.value == true
                                ? Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColors.secondary_color),
                                    onPressed: () async {
                                      controller.showLoadingBar(true);
                                      String response =
                                          await getSellAndBuyPropertyController
                                              .firestoreService
                                              .deleteProperty(property.docId!,
                                                  property.images!);
                                      if (response == 'Property Deleted') {
                                        getSellAndBuyPropertyController
                                            .getAllBuyingProperty();
                                        getSellAndBuyPropertyController
                                            .getSellProprtyOfCurrentUser();
                                        controller.showLoadingBar(false);
                                        Get.back();
                                        CustomToast.showToast(
                                            'Property Deleted');
                                      } else {
                                        CustomToast.showToast(response);
                                        controller.showLoadingBar(false);
                                        Get.back();
                                      }
                                    },
                                    child: Text('Delete Property'),
                                  ),
                          );
                        })
                      : Row(
                          children: [
                            // Expanded(
                            Expanded(child: Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: controller.showLoadingBar.value == true
                                    ? Center(child: CircularProgressIndicator())
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        onPressed: () async {
                                          controller.showLoadingBar(true);

                                          String response =
                                              await getSellAndBuyPropertyController
                                                  .firestoreService
                                                  .deleteProperty(
                                                      property.docId!,
                                                      property.images!);
                                          if (response == 'Property Deleted') {
                                            // getSellAndBuyPropertyController
                                            //     .getAllBuyingProperty();
                                            // getSellAndBuyPropertyController
                                            //     .getSellProprtyOfCurrentUser();
                                            rentAndRentOutController
                                                .getAllRentProperty();
                                            rentAndRentOutController
                                                .getRentOutProprtyOfCurrentUser();
                                            controller.showLoadingBar(false);

                                            Get.back();
                                            Get.showSnackbar(GetSnackBar(
                                              message: "Service Deleted ",
                                              duration:
                                                  Duration(microseconds: 300),
                                            ));
                                            // CustomToast.showToast(
                                            // 'Property Deleted');
                                          } else {
                                            CustomToast.showToast(response);
                                            controller.showLoadingBar(false);
                                            Get.back();
                                          }
                                        },
                                        child: Text(
                                          'حذف العقار',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                              );
                            }))
                          ],
                        ),
                )

                //service provider
              ],
            ),
          ),
        ));
  }
}
