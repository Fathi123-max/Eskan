import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';

import '../../controllers/used/favourateController.dart';
import '../../utills/customColors.dart';
import '../used/propertyDetailScreen.dart';

class RealViewCard extends GetView {
  RealViewCard({required this.property, required this.favoriteController});
  final FavoriteController favoriteController;
  var colo = Colors.white;
  PropertyModel property;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => PropertyDetailScreen(
            data: property,
          )),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: CustomColors.coral_Color,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${property.city![0].toUpperCase()}${property.city!.substring(1).toLowerCase()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  '${property.bathrooms} حمامات',
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
                                  '${property.size} قدم مربع',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${property.price.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: CustomColors.coral_Color,
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
                right: 10,
                child: GestureDetector(
                  onTap: () async {
                    if (favoriteController.isFavorite(property)) {
                      favoriteController.removeFromFavorites(property);
                    } else {
                      favoriteController.addToFavorites(property);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Obx(() {
                      return favoriteController.isFavorite(property)
                          ? const Icon(
                              Icons.favorite_outline,
                              color: CustomColors.coral_Color,
                              size: 20,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                              size: 20,
                            );
                    }),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
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
  }
}
