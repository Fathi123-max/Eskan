import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/pageViewController.dart';

import '../../controllers/used/draweController.dart';
import '../../utills/ui_tokens.dart';

/// Main home screen with bottom navigation.
///
/// Refreshed treatment:
/// - token-driven bottom navigation colors and labels
/// - calmer surface background so the tabs sit on a real surface
/// - consistent active/unselected styling without hard-coded grey/blue pairs
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageViewController pageViewController;
  late final DraweController draweController;
  late final RxInt selectedIndex;

  @override
  void initState() {
    super.initState();
    pageViewController = Get.find();
    draweController = Get.find();
    selectedIndex = 0.obs;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: _buildBody(constraints.maxWidth),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  Widget _buildBody(double maxWidth) {
    return PageView(
      controller: pageViewController.pageController.value,
      onPageChanged: _onPageChanged,
      children: pageViewController.pageViewItems,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Surface.card,
        border: Border(
          top: BorderSide(color: Accent.hairline, width: 1),
        ),
      ),
      child: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedIndex.value,
            onTap: _onTabTapped,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_rounded),
                icon: Icon(Icons.home_outlined),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite_rounded),
                icon: Icon(Icons.favorite_outline),
                label: 'المفضلة',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home_work_rounded),
                icon: Icon(Icons.home_work_outlined),
                label: 'عقاراتي',
              ),
            ],
            backgroundColor: Colors.transparent,
            selectedItemColor: Accent.primary,
            unselectedItemColor: Accent.secondary,
          )),
    );
  }

  void _onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void _onTabTapped(int index) {
    selectedIndex.value = index;
    pageViewController.pageController.value.jumpToPage(index);
  }
}
