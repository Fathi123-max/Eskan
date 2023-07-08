import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';

import '../../controllers/unused/getSellAndBuyPropertController.dart';
import 'currentUserPropertyDetail.dart';

class RentOutView extends StatelessWidget {
  // const RentOutView({Key key}) : super(key: key);
  final RentAndRentOutController rentOutController = Get.find();
  final GetSellAndBuyPropertyController rentOut2Controller =
      Get.put(GetSellAndBuyPropertyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (rentOutController.isLoading == true) {
        return Center(child: CircularProgressIndicator());
      } else {
        return rentOutController.currentUserRentOutlist.value.length == 0
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
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount:
                        rentOutController.currentUserRentOutlist.value.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.07,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Get.to(() => CurrentUserPropertyDetail(
                                data: rentOutController
                                    .currentUserRentOutlist[index]));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(rentOutController
                                        .currentUserRentOutlist[index]
                                        .images![0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rentOutController
                                          .currentUserRentOutlist[index]
                                          .address!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      rentOutController
                                          .currentUserRentOutlist[index].descr!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${rentOutController.currentUserRentOutlist[index].city![0].toUpperCase()}${rentOutController.currentUserRentOutlist[index].city!.substring(1).toLowerCase()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
      }
    }));
  }
}
