import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/services/PropertyServices.dart';
import 'package:haider/utills/customColors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddPropertyController extends GetxController {
  // Variables
  var showLoadingBar = false.obs;
  var selectedCity = 'دمياط'.obs;
  var selectedValue = 'اختار نوع العقار'.obs;
  var selectedColor = CustomColors.prime_color.obs;
  var unSelectedColor = CustomColors.secondary_color.obs;
  var images = <Asset>[].obs;
  final PropertyModel propertyModel = PropertyModel();
  final PropertyServices firestoreService = PropertyServices();
  final propertyFormKey = GlobalKey<FormState>();

  // Form controllers
  final cityEditTextController = TextEditingController();
  final areaEditTextController = TextEditingController();
  final addressEditTextController = TextEditingController();
  final sizeEditTextController = TextEditingController();
  final bedroomsEditTextController = TextEditingController();
  final bathroomsTextController = TextEditingController();
  final kitchenEditTextController = TextEditingController();
  final hallEditTextController = TextEditingController();
  final desEditTextController = TextEditingController();
  final priceEditTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // Clean up controllers
    cityEditTextController.dispose();
    areaEditTextController.dispose();
    addressEditTextController.dispose();
    sizeEditTextController.dispose();
    bedroomsEditTextController.dispose();
    bathroomsTextController.dispose();
    kitchenEditTextController.dispose();
    hallEditTextController.dispose();
    desEditTextController.dispose();
    priceEditTextController.dispose();
    super.onClose();
  }

  /// Pick images for the property listing
  Future<void> getImage() async {
    final pickedImages = await MultiImagePicker.pickImages(
      maxImages: 7,
      enableCamera: true,
      selectedAssets: images,
    );
    if (pickedImages != null) {
      images.value = pickedImages;
    }
  }
}
