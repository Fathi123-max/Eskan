import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/views/screens/google_signin_page.dart';

import '../../controllers/used/draweController.dart';
import '../../controllers/used/pageViewController.dart';
import '../../utills/ui_tokens.dart';

/// Drawer widget for app navigation.
///
/// Refreshed treatment:
/// - calmer navigation chrome that reads as a surface, not a loud color block
/// - one consistent active state using the token accent
/// - localized logout label kept, but styled consistently with the rest of the UI
class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final draweController = Get.find<DraweController>();
    final pageViewController = Get.find<PageViewController>();
    final box = GetStorage();

    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildNavigationList(draweController, pageViewController),
          ),
          _buildLogoutSection(box),
        ],
      ),
      color: Surface.card,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(Space.sm),
      child: Column(
        children: [
          Image(
            asset: 'assets/images/icon.png',
            height: 120,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: Space.sm),
          Text(
            'إسكان',
            style: Type.arabicHeadline(size: 22),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationList(DraweController controller, PageViewController pageController) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Space.xs),
      itemCount: controller.drawerItemsList.length,
      itemBuilder: (context, index) {
        final item = controller.drawerItemsList[index];
        final isSelected = controller.selectedDrawerIndex.value == index;

        return _buildNavigationItem(
          item: item,
          isSelected: isSelected,
          onTap: () => _onItemTapped(
            index: index,
            controller: controller,
            pageController: pageController,
            context: context,
          ),
        );
      },
    );
  }

  Widget _buildNavigationItem({
    required DrawerItem item,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 1.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const RoundedRectangleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.sm,
              vertical: Space.xs,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: isSelected ? Accent.primary : Accent.secondary,
                  size: 22,
                ),
                const SizedBox(width: Space.sm),
                Expanded(
                  child: Text(
                    item.title,
                    style: Type.metadataStyle(
                      size: 14,
                      weight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Accent.primary : Accent.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped({
    required int index,
    required DraweController controller,
    required PageViewController pageController,
    required BuildContext context,
  }) {
    controller.selectedDrawerIndex.value = index;
    controller.update();
    pageController.pageViewIndex.value = 0;
    Navigator.pop(context);
  }

  Widget _buildLogoutSection(GetStorage box) {
    return Container(
      margin: const EdgeInsets.all(Space.sm),
      decoration: BoxDecoration(
        color: Accent.primary,
        borderRadius: BorderRadius.circular(Radius.chip),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleLogout(box),
          customBrightness: Brightness.light,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Space.xs,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: Space.xs),
                Text(
                  'logout'.tr,
                  style: Type.metadataStyle(
                    color: Colors.white,
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(GetStorage box) async {
    box.remove('name');
    box.remove('phone');
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const GoogleLoginScreen());
  }
}
