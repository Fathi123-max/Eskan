import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/services/PropertyServices.dart';

class RentAndRentOutController extends GetxController {
  PropertyServices firestoreService = PropertyServices();
  var currentUserRentOutlist = <PropertyModel>[].obs;
  var username = "".obs;
  var allRentList = <PropertyModel>[].obs;
  var allcatList = <PropertyModel>[].obs;
  var isLoading = false.obs;
  var value = true.obs;

  getRentOutProprtyOfCurrentUser() async {
    isLoading(true);
    var newList = await firestoreService.getCurrentUserPropertyForRentOut();
    currentUserRentOutlist.value = newList;
    isLoading(false);
  }

  getAllRentProperty() async {
    isLoading(true);
    var newList = await firestoreService.getAllRentList();
    allRentList.value = newList;
    print(allRentList.value);
    print("******************************");
    isLoading(false);
  }

  getAllRentPropertyFirestorePagnation() {
    return firestoreService.firestorePagnation();
  }

  getAllRentPropertyByCategory(String search) async {
    isLoading(true);
    var categoryList =
        await firestoreService.getAllRentListByCategory(category: search);
    allcatList.value = categoryList;
    isLoading(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRentOutProprtyOfCurrentUser();
    getAllRentProperty();
    getAllRentPropertyFirestorePagnation();
    print("-----------------------");
  }
  // @override
  // void refresh() {
  //   // TODO: implement refresh
  //   super.refresh();
  //   getRentOutProprtyOfCurrentUser();
  //   getAllRentProperty();
  // }
}
