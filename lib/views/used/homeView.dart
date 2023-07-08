import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/pageViewController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/views/used/accountSetttings.dart';

import '../../controllers/used/draweController.dart';
import 'choosescreen.dart';
import 'info.dart';
import 'rooms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController _pageController;

  // final ValueNotifier<int> _pageIndex ;
  final PageViewController pageViewController = Get.put(PageViewController());
  final DraweController draweController = Get.put(DraweController());
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    pageViewController.pageViewIndex.addListener(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  itemCount: draweController.drawerItemsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        draweController.drawerItemsList[index].icon,
                        color: draweController.selectedDrawerIndex == index
                            ? CustomColors.prime_color
                            : CustomColors.secondary_color,
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
                                : CustomColors.secondary_color),
                      ),
                      onTap: () {
                        print(index);
                        index == 1 ? Get.to(() => AccountSettings()) : null;
                        index == 2 ? Get.to(() => RoomsPage()) : null;
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
      )),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        // centerTitle: true,
        title: Text(
          'Services'.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.secondary_color,
              fontSize: 22),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => Info());
              },
              icon: Icon(Icons.info)),
        ],
      ),
      bottomNavigationBar: BottomBarDefault(
          top: 5,
          animated: true,
          items: [
            TabItem(icon: Icons.home, title: 'Home'.tr),
            TabItem(icon: Icons.design_services_sharp, title: 'Services'.tr),
            TabItem(icon: Icons.favorite, title: 'Favorite'.tr),
            TabItem(icon: Icons.people, title: 'My Services'.tr),
          ],
          backgroundColor: CustomColors.prime_color,
          color: CustomColors.secondary_color,
          colorSelected: Colors.orange,
          onTap: (int index) => setState(() {
                _pageController.jumpToPage(index);
              })),

      //  ConvexAppBar(
      //   height: 55,
      //   controller: _tabController,
      //   backgroundColor: CustomColors.prime_color,
      //   items:,
      //   onTap: (int i) {
      //     _pageIndex.value = i;
      //   },
      //   style: TabStyle.custom,
      // ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {},
              controller: _pageController,
              children: pageViewController.pageViewItems,
            ),
          ),
        ],
      ),
    );
  }
}
