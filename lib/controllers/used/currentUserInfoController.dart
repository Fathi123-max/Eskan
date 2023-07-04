import 'package:get/get.dart';
import 'package:haider/models/unused/userModel.dart';
import 'package:haider/services/firestoreService.dart';

class CurrentUserInfoController extends GetxController {
  // AuthController authController = Get.find();
  var selectedIndex = 0.obs;
  var Id = ''.obs;
  var currentUserinformation;
  var currentUserId = ''.obs;
  FirestoreService firestoreService = FirestoreService();
  var userInfo = UserModel(
          firstName: 'sdsf',
          lastName: 'sdfds',
          phoneNumber: '0422045',
          userEmail: '545645',
          userPassword: '')
      .obs;
  var currentUserInfo = UserModel(
          firstName: '454564',
          lastName: '54545',
          phoneNumber: '654564',
          userEmail: '989+7',
          userPassword: '56456456')
      .obs;
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
