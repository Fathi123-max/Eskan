import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';
import 'package:haider/utills/customColors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddPropertyController extends GetxController {
  //Variables
  var showLoadingBar = false.obs;
  var selectedCity = 'دمياط'.obs;
  // var citieslist = <CityModel>[CityModel("cairo")].obs;
  var citieslist2 =
      ['Kar Albattikh'.tr, 'Dammita'.tr, "new Dammita".tr, "Kar Saad".tr].obs;

  var values = <String>[
    'Driver',
    "Plumbing",
    "Carpentry".tr,
    'Gardening'.tr,
    'Cleaning Houses'.tr,
    'Electrician'.tr,
    'Blacksmith'.tr,
    'Tiling'.tr,
    'Teacher'.tr,
    'Gardening'.tr,
    'Nurse'.tr,
    'Mecanical'.tr,
    'Baby setter'.tr,
    'Color Man'.tr,
    'Ground Man'.tr,
    'other'.tr,
  ].obs;
  var selectedValue = 'Carpentry'.obs;
  var selectedColor = CustomColors.prime_color.obs;
  var unSelectedColor = CustomColors.blue_color.obs;
  var images = <Asset>[].obs;
  PropertyModel propertyModel = PropertyModel();
  FirestoreService firestoreService = FirestoreService();
  var propertyFormKey = GlobalKey<FormState>();
  final cityEditTextController = TextEditingController();
  var areaEditTextController = TextEditingController();
  var addressEditTextController = TextEditingController();
  var sizeEditTextController = TextEditingController();
  var bedroomsEditTextController = TextEditingController();
  var bathroomsTextController = TextEditingController();
  var kitchenEditTextController = TextEditingController();
  var desEditTextController = TextEditingController();
  var priceEditTextController = TextEditingController();

////////////////////////////////////////////
  //Mathods

  Future getImage() async {
    var image = await MultiImagePicker.pickImages(
        maxImages: 7, enableCamera: true, selectedAssets: images);
    images.value = image;
  }

  // Future<void> getCitiesData() async {
  //   var list = await firestoreService.getcitiesList();
  //   citieslist.value = list;
  // }

  @override
  void onInit() {
    super.onInit();

    //  getCitiesData();
  }
}
