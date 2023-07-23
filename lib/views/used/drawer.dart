import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/views/screens/rooms.dart';

import '../../controllers/used/draweController.dart';
import '../../controllers/used/pageViewController.dart';
import '../../utills/customColors.dart';
import '../screens/add_information.dart';

class Drawerwidget extends StatelessWidget {
  Drawerwidget({super.key});
  final DraweController draweController = Get.put(DraweController());
  final box = GetStorage();

  final PageViewController pageViewController = Get.put(PageViewController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.gif',
                  height: 200,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                // shrinkWrap: true,
                itemCount: draweController.drawerItemsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      draweController.drawerItemsList[index].icon,
                      color: draweController.selectedDrawerIndex == index
                          ? CustomColors.prime_color
                          : CustomColors.green_color,
                    ),
                    title: Text(
                      draweController.drawerItemsList[index].title,
                      style: TextStyle(
                          fontWeight:
                              draweController.selectedDrawerIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color: draweController.selectedDrawerIndex == index
                              ? CustomColors.prime_color
                              : CustomColors.green_color),
                    ),
                    onTap: () {
                      print(index);
                      draweController.selectedDrawerIndex.value = index;
                      draweController.update();
                      pageViewController.pageViewIndex.value = 0;

                      index == 2 ? Get.to(() => RoomsPage()) : Get.back();
                      Navigator.pop(context);
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.prime_color,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Log Out'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onTap: () async {
                    // await FirebaseAuth.instance.signOut();
                    // authController.currentUser(false);
                    // authController.update();
                    // pageViewController.pageViewIndex.value = 0;
                    box.remove('name');
                    box.remove('phone');
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(() => EnterInfo());
                  },
                ),
              ),
            ),
          )
        ],
      ),
      color: Colors.white,
    ));
  }
}
