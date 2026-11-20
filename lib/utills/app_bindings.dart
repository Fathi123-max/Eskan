import 'package:get/get.dart';

import '../controllers/used/addpropertyController.dart';
import '../controllers/used/catogryconroller.dart';
import '../controllers/used/citycontroller.dart';
import '../controllers/used/currentUserInfoController.dart';
import '../controllers/used/draweController.dart';
import '../controllers/used/favourateController.dart';
import '../controllers/used/getSellAndBuyPropertController.dart';
import '../controllers/used/pageViewController.dart';
import '../controllers/used/rentAndRentOutController.dart';
import '../controllers/used/search_controller.dart';
import '../controllers/used/themeControllers.dart';

/// Centralized bindings for all app controllers.
/// Register once here and use Get.find() everywhere else.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Singletons that live for the entire app lifetime
    Get.put(ThemeController(), permanent: true);
    Get.put(FavoritesController(), permanent: true);

    // Controllers that may be accessed from multiple places
    Get.put(RentAndRentOutController(), fenix: true);
    Get.put(GetSellAndBuyPropertyController(), fenix: true);
    Get.put(CityController(), fenix: true);
    Get.put(CategoryController(), fenix: true);
    Get.put(DraweController(), fenix: true);
    Get.put(PageViewController(), fenix: true);
    Get.put(CurrentUserInfoController(), fenix: true);
    Get.put(AddPropertyController(), fenix: true);
    Get.put(SearchControllerCustom(), fenix: true);
  }
}
