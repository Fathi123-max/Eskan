import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/used/catogrymodel.dart';
import '../../services/PropertyServices.dart';

class CategoryController extends GetxController {
  final RxList<Category> categoryList = RxList<Category>([]);
  StreamSubscription? _categorySubscription;

  @override
  void onInit() {
    _loadCategories();
    super.onInit();
  }

  void _loadCategories() {
    final services = PropertyServices();
    _categorySubscription = services.getAllCategories().listen((event) {
      categoryList.value = event;
    });
  }

  @override
  void onClose() {
    _categorySubscription?.cancel();
    super.onClose();
  }
}
