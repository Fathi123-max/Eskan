import 'package:get/get.dart';
import 'package:haider/views/used/rentOutView.dart';
import 'package:haider/views/used/rentView.dart';

import '../views/used/addDataScreen.dart';
import '../views/used/catogries/carogrylist.dart';

class PageViewController extends GetxController {
  var pageViewIndex = 0.obs;
  var pageViewItems = [
    RentView(),
    catogrylist(),
    AddDataScreen(
      value: '',
    ),
    RentOutView(),

    // SellView(),
  ];
}
