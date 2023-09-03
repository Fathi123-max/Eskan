import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/services/PropertyServices.dart';

class RentAndRentOutController extends GetxController {
  // final AuthController controller = Get.find();
  PropertyServices firestoreService = PropertyServices();
  var currentUserRentOutlist = <PropertyModel>[].obs;
  var username = "".obs;
  var allRentList = <PropertyModel>[].obs;
  var allcatList = [].obs;
  var isLoading = false.obs;
  var value = true.obs;
/////////////////////////////////////////////////////
  final cityEditTextController = TextEditingController();
  final rangeTextFromController = TextEditingController();
  final rangeTextToTextController = TextEditingController();
  //////////////////////////////////////////////////

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
    return firestoreService.firestorePagination();
  }

  getAllRentPropertyByCatogry(String search) async {
    isLoading(true);
    var catogrybyname =
        await firestoreService.getAllRentListByCatogry(search: search);
    allcatList.value = catogrybyname;
    isLoading(false);
  }

  Query<Map<String, dynamic>>? quary;
  final box = GetStorage();
  getdata() async {
    quary = box.read("name") != null
        ? await FirebaseFirestore.instance
            .collection('property')
            .where('username', isEqualTo: box.read("name"))
            .where('usernumber', isEqualTo: box.read("phone"))
        : null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getdata();
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
