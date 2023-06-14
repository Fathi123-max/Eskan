import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/draweController.dart';
import 'package:haider/controllers/pageViewController.dart';
import 'package:haider/utills/customColors.dart';

import 'choosescreen.dart';

class NavDrawerScreen extends StatelessWidget {
  // final AuthController authController = Get.find();
  final DraweController draweController = Get.put(DraweController());
  final PageViewController pageViewController = Get.put(PageViewController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
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
                              ? CustomColors.orangeColor
                              : CustomColors.greyColor,
                        ),
                        title: Text(
                          draweController.drawerItemsList[index].title,
                          style: TextStyle(
                              fontWeight:
                                  draweController.selectedDrawerIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color:
                                  draweController.selectedDrawerIndex == index
                                      ? CustomColors.orangeColor
                                      : CustomColors.greyColor),
                        ),
                        onTap: () {
                          print(index);
                          draweController.selectedDrawerIndex.value = index;
                          draweController.update();
                          pageViewController.pageViewIndex.value = 0;
                          Navigator.pop(context);
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.orangeColor,
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

                        Get.offAll(() => EnterInfo());
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          color: Colors.white,
        )),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          // centerTitle: true,
          title: Obx(() {
            return Text(
              draweController.selectedDrawerIndex.value == 2
                  ? 'Account Setting'.tr
                  : 'Services'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.greyColor,
                  fontSize: 22),
            );
          }),
          actions: [
            IconButton(
                onPressed: () {
                  // Get.to(() => ExampleScreen());
                  Get.updateLocale(const Locale('ar', 'EG'));
                  // Get.changeTheme(Get.isDarkMode
                  //     ? ThemeData.light(useMaterial3: true)
                  //     : ThemeData.dark(
                  //         useMaterial3: true,
                  //       ));
                },
                icon: Icon(Icons.dark_mode)),
          ],
        ),
        body: Obx(() {
          return IndexedStack(
            index: draweController.selectedDrawerIndex.value,
            children: draweController.drawerChildrens.value,
          );
        }),
      ),
    );
  }
}
