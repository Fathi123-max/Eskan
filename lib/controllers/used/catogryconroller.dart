import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/catogrymodel.dart';
import '../../services/firestoreService.dart';

class catogryController extends GetxController {
  RxList<User> catogryList = RxList<User>([]);

  @override
  void onInit() async {
    await getAllcatogryList();

    super.onInit();
  }

  Future<String> getAllcatogryList() async {
    await FirestoreService().getAllupdaetList().listen((event) {
      catogryList.value = event;
    });
    return "";
  }
}
