import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/pageViewController.dart';
import 'package:haider/utills/customColors.dart';

import '../../controllers/used/draweController.dart';
import '../used/drawer.dart';
import '../used/info.dart';

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
            color: CustomColors.coral_Color,
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
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedIndex.value,
            onTap: (index) {
              selectedIndex.value = index; // Update the selected index
              pageViewController.pageController.value
                  .jumpToPage(index); // Go to the selected page
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_rounded),
                icon: Icon(Icons.home_outlined),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite_rounded),
                icon: Icon(Icons.favorite_outline),
                label: 'المفضله'.tr,
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.people_rounded),
                icon: Icon(Icons.people_outline),
                label: 'My Services'.tr,
              ),
            ],
            backgroundColor: Colors.white,
            selectedItemColor: CustomColors.prime_color,
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
