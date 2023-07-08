import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haider/models/used/cityModel.dart';

import '../../services/PropertyServices.dart';

class CityController extends GetxController {
  RxList<CityModel> cityList = RxList<CityModel>([]);

  @override
  void onInit() async {
    await getAllcatogryList();

    super.onInit();
  }

  Future<String> getAllcatogryList() async {
    await PropertyServices().getAllcityList().listen((event) {
      cityList.value = event;
    });
    return "";
  }
}
