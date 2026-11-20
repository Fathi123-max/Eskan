import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haider/models/used/cityModel.dart';

import '../../services/PropertyServices.dart';

class CityController extends GetxController {
  final RxList<CityModel> cityList = RxList<CityModel>([]);
  StreamSubscription? _citySubscription;

  @override
  void onInit() {
    _loadCities();
    super.onInit();
  }

  void _loadCities() {
    final services = PropertyServices();
    _citySubscription = services.getAllCities().listen((event) {
      cityList.value = event;
    });
  }

  @override
  void onClose() {
    _citySubscription?.cancel();
    super.onClose();
  }
}
