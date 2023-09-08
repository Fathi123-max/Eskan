import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/views/compunants/rentviewcard.dart';

import '../../controllers/used/favourateController.dart';

class FavoritesPage extends GetView {
// Get the controller instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final favorites = Get.find<FavoritesController>()
            .favorites; // Get the list of favorite properties

        if (favorites.isEmpty) {
          // Display a message when there are no favorite properties
          return Center(
            child: Text(
              'لم تفضل عقار بعد',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }

        // Display the list of favorite properties using ListView.builder
        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final property = favorites[index];

            // Replace this with your custom UI to display each property
            return SizedBox(
                height: 300, child: RealViewCard(property: property));
            // Add other details you want to display for each property
          },
        );
      }),
    );
  }
}
