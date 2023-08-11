import 'package:get/get.dart';
import 'package:haider/services/PropertyServices.dart';

class CurrentUserInfoController extends GetxController {
  // AuthController authController = Get.find();
  var selectedIndex = 0.obs;
  var Id = ''.obs;
  var currentUserinformation;
  var currentUserId = ''.obs;
  PropertyServices firestoreService = PropertyServices();

  var isLoading = false.obs;
  var showLoadingBar = false.obs;

  // Future<void> getUserInfo() async {
  //   isLoading(true);
  //   var userInfoNew = await firestoreService.getUserInfo(Id.value);
  //   userInfo.value = userInfoNew;
  //   //CustomToast.showToast('userId ${userInfoNew.currentUserId}');

  //   isLoading(false);
  // }

  Future<void> getCurrentUserInfo() async {
    // CustomToast.showToast(authController.currentUserId.value);

    showLoadingBar(true);
    // var userInfoNew =
    //     await firestoreService.getUserInfo(authController.currentUserId.value);
    // currentUserInfo.value = UserModel();

    showLoadingBar(false);
  }

  @override
  void onInit() {
    // getUserInfo();
    getCurrentUserInfo();
    super.onInit();
  }
}
