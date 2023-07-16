import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/pageViewController.dart';
import 'package:haider/utills/customColors.dart';

import '../../controllers/used/draweController.dart';
import 'drawer.dart';
import 'info.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageViewController pageViewController = Get.put(PageViewController());
  final DraweController draweController = Get.put(DraweController());
  final box = GetStorage();
  var selectedIndex = 0.obs; // Use Rx variable for state management

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerwidget(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Services'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColors.secondary_color,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => Info());
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: selectedIndex.value,
            onTap: (index) {
              selectedIndex.value = index; // Update the selected index
              pageViewController.pageController.value
                  .jumpToPage(index); // Go to the selected page
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: 'المحادثات'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'My Services'.tr,
              ),
            ],
            backgroundColor: CustomColors.prime_color,
            selectedItemColor: Colors.orange,
            unselectedItemColor: CustomColors.coral_Color,
          )),
      body: PageView(
        controller: pageViewController.pageController.value,
        onPageChanged: (index) {
          selectedIndex.value =
              index; // Update the selected index when page changes
        },
        children: pageViewController.pageViewItems,
      ),
    );
  }
}
