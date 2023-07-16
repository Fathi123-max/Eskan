import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:hive/hive.dart';

import '../../utills/customColors.dart';
import '../used/Untitled-1.dart';

class RealViewCard extends GetView {
  RealViewCard({required this.property});
  var colo = Colors.white;
  final favouritesBox = Hive.box('favourites');
  PropertyModel property;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => PropertyDetail(
            data: property,
          )),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(
                property.images![0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 500,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.address!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${property.city![0].toUpperCase()}${property.city!.substring(1).toLowerCase()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.king_bed),
                              Text(
                                ' ${property.bedrooms} | ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.bathtub),
                              Text(
                                ' ${property.bathrooms} | ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.aspect_ratio),
                              Text(
                                ' ${property.size}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${property.price.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: CustomColors.coral_Color),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 30,
                child: GestureDetector(
                  onTap: () async {
                    final favouritesBox = await Hive.box('favourites');
                    favouritesBox.add(property);
                    print(property);
                    print("propertyAdded");
                  },
                  child: Icon(
                    Icons.favorite_outlined,
                    color: colo,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
