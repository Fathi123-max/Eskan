import 'package:get/get.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/services/PropertyServices.dart';

class SearchRentController extends GetxController {
  final RentAndRentOutController rentAndRentOutController = Get.find();
  var rentSerachList = <PropertyModel>[].obs;
  PropertyServices firestoreService = PropertyServices();
  var isLoading = false.obs;

  Future<void> searchRentList() async {
    isLoading(true);
    var list = await firestoreService.serachRentList(
        rentAndRentOutController.cityEditTextController.text,
        rentAndRentOutController.rangeTextFromController.text,
        rentAndRentOutController.rangeTextToTextController.text);
    rentSerachList.value = list;
    isLoading(false);
  }

  @override
  void refresh() {
    // TODO: implement refresh
    searchRentList();
    super.refresh();
  }
}
