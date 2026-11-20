import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/used/rentAndRentOutController.dart';
import '../../../utills/app_bindings.dart';

class CategoryViewPage extends StatelessWidget {
  final String action;

  CategoryViewPage({
    required this.action,
  });

  final RentAndRentOutController rentAndRentOutController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(action),
      ),
      body: Obx(() {
        if (rentAndRentOutController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: rentAndRentOutController.allRentList.length,
            itemBuilder: (context, index) {
              if (rentAndRentOutController.allRentList[index].action ==
                  action) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: rentAndRentOutController
                                  .allRentList[index].firstImageUrl ?? '',
                              fit: BoxFit.cover,
                              height: 150,
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  rentAndRentOutController
                                      .allRentList[index].address!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '${rentAndRentOutController.allRentList[index].city}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        }
      }),
    );
  }
}
