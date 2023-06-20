import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/drawerItems.dart';

class DraweController extends GetxController {
  var selectedDrawerIndex = 0.obs;
  var selectednavIndex = 0.obs;

  var drawerItemsList = <DrawerItem>[
    DrawerItem(title: 'Home'.tr, icon: Icons.home_outlined),
    // DrawerItem(title: 'Liked Property ', icon: Icons.favorite_outline),
    DrawerItem(title: 'Account Setting'.tr, icon: Icons.settings_outlined),
    DrawerItem(title: 'Rooms'.tr, icon: Icons.settings_outlined),
  ].obs;
}
