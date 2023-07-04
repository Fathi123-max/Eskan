import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/pageViewController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/views/used/accountSetttings.dart';

import '../../controllers/draweController.dart';
import 'choosescreen.dart';
import 'info.dart';
import 'rooms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  final ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
  final PageViewController pageViewController = Get.put(PageViewController());
  final DraweController draweController = Get.put(DraweController());
  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _pageIndex.value);
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: _pageIndex.value);
    _pageIndex.addListener(() {
      _pageController.jumpToPage(_pageIndex.value);
      _tabController.animateTo(_pageIndex.value);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    _pageIndex.dispose();
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
                  // shrinkWrap: true,
                  itemCount: draweController.drawerItemsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        draweController.drawerItemsList[index].icon,
                        color: draweController.selectedDrawerIndex == index
                            ? CustomColors.prime_color
                            : CustomColors.blue_color,
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
                                : CustomColors.blue_color),
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
      )),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        // centerTitle: true,
        title: Text(
          'Services'.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.blue_color,
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
      bottomNavigationBar: ConvexAppBar(
        height: 55,
        controller: _tabController,
        backgroundColor: CustomColors.prime_color,
        items: [
          TabItem(icon: Icons.home, title: 'Home'.tr),
          TabItem(icon: Icons.design_services_sharp, title: 'Services'.tr),
          TabItem(icon: Icons.favorite, title: 'Favorite'.tr),
          TabItem(icon: Icons.people, title: 'My Services'.tr),
        ],
        onTap: (int i) {
          _pageIndex.value = i;
        },
        style: TabStyle.custom,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                _pageIndex.value = index;
              },
              controller: _pageController,
              children: pageViewController.pageViewItems,
            ),
          ),
        ],
      ),
    );
  }
}
