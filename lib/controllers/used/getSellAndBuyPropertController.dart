import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/services/PropertyServices.dart';

class GetSellAndBuyPropertyController extends GetxController {
  PropertyServices firestoreService = PropertyServices();
  var currentUserSellinglist = <PropertyModel>[].obs;
  var allBuyList = <PropertyModel>[].obs;
  var isLoading = false.obs;

  getSellProprtyOfCurrentUser() async {
    isLoading(true);
    var newList = await firestoreService.getCurrentUserPropertyForSelling();
    currentUserSellinglist.value = newList;
    isLoading(false);
  }

  getAllBuyingProperty() async {
    isLoading(true);
    var newList = await firestoreService.getAllBuyingList();
    allBuyList.value = newList;
    isLoading(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSellProprtyOfCurrentUser();
    getAllBuyingProperty();
  }
  // @override
  // void refresh() {
  //   // TODO: implement refresh
  //   super.refresh();
  // //  CustomToast.showToast('refreshed');
  //   getSellProprtyOfCurrentUser();
  //   getAllBuyingProperty();
  // }
}
