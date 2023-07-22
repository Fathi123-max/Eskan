import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/views/used/home_page.dart';
import 'package:haider/views/used/rentOutView.dart';

import '../../views/screens/favscreen.dart';

class PageViewController extends GetxController {
  var pageViewIndex = 0.obs;
  var pageViewItems = [
    HomePage(),

    FavoritePage(),
    UserProperties(),

    // SellView(),
  ];

  var pageController = PageController().obs;
}
