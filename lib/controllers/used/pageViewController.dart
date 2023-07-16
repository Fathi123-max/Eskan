import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/views/used/rentOutView.dart';
import 'package:haider/views/used/rentView.dart';
import 'package:haider/views/used/rooms.dart';

import '../../views/screens/favscreen.dart';

class PageViewController extends GetxController {
  var pageViewIndex = 0.obs;
  var pageViewItems = [
    HomePage(),

    RoomsPage(),
    FavoritePage(),
    UserProperties(),

    // SellView(),
  ];

  var pageController = PageController().obs;
}
