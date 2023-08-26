import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/addpropertyController.dart';
import 'package:haider/controllers/used/catogryconroller.dart';
import 'package:haider/controllers/used/currentUserInfoController.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/customToast.dart';
import 'package:haider/views/screens/screen_added_page.dart';
import 'package:latlong2/latlong.dart' as locmap;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/used/citycontroller.dart';
import '../../utills/map_screen.dart';

class AddDataScreen extends StatelessWidget {
  final String value;

  AddDataScreen({super.key, required this.value});

  final box = GetStorage();

  final AddPropertyController controller = Get.find<AddPropertyController>();

  final RentAndRentOutController rentAndRentOutController = Get.find();

  final CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'addProperty',
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ],
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Form(
            key: controller.propertyFormKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Service'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.prime_color,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enter Service details to listed on Services'.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Service Name'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.addressEditTextController,
                    keyboardType: TextInputType.text,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'أدخل اسم العقار'.tr,
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.work,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Address  required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.address = value.toString();
                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Type of Service'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: () => showService(context),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 8, bottom: 2),
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColors.prime_color, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.hail,
                                  color: Colors.black54,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${Get.put(AddPropertyController()).selectedValue}"
                                        .tr,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showService(context);
                                    },
                                    icon: const Icon(Icons.arrow_drop_down))
                              ],
                            ),
                          ))),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select City'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: () => showCitiesListDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 8, bottom: 2),
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColors.prime_color, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.location_city_outlined,
                                  color: Colors.black54,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${controller.selectedCity.value[0].toUpperCase()}${controller.selectedCity.value.substring(1).toLowerCase()}',
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showCitiesListDialog(context);
                                    },
                                    icon: const Icon(Icons.arrow_drop_down))
                              ],
                            ),
                          ))),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select Area'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.areaEditTextController,
                    keyboardType: TextInputType.text,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'Area'.tr,
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) return 'Area  required';
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.area = value.toString().trim();
                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),
                // add sections
                Padding(
                  padding: EdgeInsets.all(8),
                  child: OutlinedButton(
                      onPressed: () {
                        Get.bottomSheet(BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return OpenStreetMapSearchAndPick(
                                center: const LatLong(23, 89),
                                buttonColor: Colors.blue,
                                buttonText: 'Set Current Location',
                                onPicked: (pickedData) {
                                  controller.propertyLocationX.value =
                                      pickedData.latLong.latitude;
                                  controller.propertyLocationY.value =
                                      pickedData.latLong.longitude;
                                  controller.areaEditTextController.text =
                                      pickedData.addressName;
                                  Get.back();
                                  print(pickedData.latLong.latitude);
                                  print(pickedData.latLong.longitude);
                                  print(pickedData.address);
                                });
                          },
                        ));
                      },
                      child: Text("GetLocation")),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(children: [
                    Positioned(
                        top: 20,
                        left: 20,
                        child: GestureDetector(
                          child: const Icon(
                            size: 25,
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                        )),
                    Container(
                        width: Get.width,
                        height: Get.height * .2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() => MapWidget(
                            location: locmap.LatLng(
                                controller.propertyLocationX.value,
                                controller.propertyLocationY.value)))),
                  ]),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'المساحه',
                        style: TextStyle(
                            fontSize: 18,
                            color: CustomColors.secondary_color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 8, bottom: 2),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.sizeEditTextController,
                        keyboardType: TextInputType.number,
                        cursorColor: CustomColors.prime_color,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '',
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: CustomColors.prime_color)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: CustomColors.prime_color)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: CustomColors.prime_color)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: CustomColors.prime_color)),
                          labelText: 'المساحه بالمتر',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.photo_size_select_small_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'Area  required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          controller.propertyModel.size = value.toString();
                          //authController.userModel.userEmail = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'غرف النوم',
                    style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.bedroomsEditTextController,
                    keyboardType: TextInputType.number,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'عدد غرف النوم',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.bed_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'No of Bedrooms  required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.bedrooms = value.toString();
                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'الحمامات',
                    style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.bathroomsTextController,
                    keyboardType: TextInputType.number,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'عدد الحمامات',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.bathroom_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'No of Bathrooms required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.bathrooms = value.toString();
                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'المطبخ',
                    style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.kitchenEditTextController,
                    keyboardType: TextInputType.number,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'عدد المطابخ',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.kitchen_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'No of Kitchens required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.kitchen = value.toString();
                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'الاستقبال',
                    style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.hallEditTextController,
                    keyboardType: TextInputType.number,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'عدد اماكن الاستقبال',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.chair_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) return 'hall required';
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.propertyFor = value.toString();
                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value == 'sale' ? 'Price' : 'الايجار / الشهر',
                    style: const TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.priceEditTextController,
                    keyboardType: TextInputType.number,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: value == 'sale' ? 'Price' : 'الايجار',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.label_important_outline,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) return 'Price required';
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.price = value.toString();
                    },
                  ),
                ),
                // end sections
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: CustomColors.secondary_color,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: TextFormField(
                    maxLines: 5,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.desEditTextController,
                    keyboardType: TextInputType.text,
                    cursorColor: CustomColors.prime_color,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '',
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: CustomColors.prime_color)),
                      labelText: 'Description'.tr,
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Detailed Description required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.propertyModel.descr = value.toString();

                      //authController.userModel.userEmail = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 40),
                          backgroundColor: CustomColors.prime_color),
                      child: Text(
                        "Select Images".tr,
                        style: const TextStyle(color: CustomColors.Lite_color),
                      ),
                      onPressed: () {
                        controller.getImage();
                      }),
                ),
                Obx(() {
                  return controller.images.value.isEmpty
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 22, right: 22, top: 8),
                          child: GridView.count(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: List.generate(
                                controller.images.value.length, (index) {
                              Asset asset = controller.images.value[index];
                              print(asset.getByteData(quality: 30));
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: AssetThumb(
                                    asset: asset,
                                    width: 300,
                                    height: 300,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: controller.showLoadingBar == false
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                                backgroundColor: CustomColors.green_color),
                            child: Text(
                              "Save Property".tr,
                              style: const TextStyle(
                                  color: CustomColors.Lite_color),
                            ),
                            onPressed: () async {
                              if (controller.images.value.isEmpty) {
                                CustomToast.showToast('Please Select images');
                              } else {
                                if (!controller.propertyFormKey.currentState!
                                    .validate()) {
                                  return;
                                }

                                controller.propertyModel.city =
                                    controller.selectedCity.value;
                                // Generate a new UUID
                                var uuid = const Uuid();
                                String uniqueId = uuid.v4();

                                controller.propertyModel.currentUserId =
                                    uniqueId;
                                controller.propertyModel.propertyType =
                                    controller.selectedValue.value;
                                controller.propertyFormKey.currentState!.save();
                                controller.showLoadingBar(true);
                                String response = await controller
                                    .firestoreService
                                    .addproprtyToDatabase(
                                  controller.propertyModel,
                                  controller.images.value,
                                );
                                Get.off(() => SuccessScreen(
                                    property: controller.propertyModel));
                                if (response == 'Data added') {
                                  controller.showLoadingBar(false);
                                  // CustomToast.showToast('Proprty Added');
                                  Get.showSnackbar(const GetSnackBar(
                                    message: 'Proprty Added',
                                    duration: Duration(milliseconds: 300),
                                  ));
                                  // sellPropertyController
                                  //     .getSellProprtyOfCurrentUser();

                                  rentAndRentOutController.getAllRentProperty();

                                  rentAndRentOutController
                                      .getRentOutProprtyOfCurrentUser();

                                  // sellPropertyController.getAllBuyingProperty();
                                  // currentUserInfoController.getUserInfo();
                                  controller.areaEditTextController.clear();
                                  controller.addressEditTextController.clear();
                                  controller.sizeEditTextController.clear();
                                  controller.bedroomsEditTextController.clear();
                                  controller.bathroomsTextController.clear();
                                  controller.kitchenEditTextController.clear();
                                  controller.desEditTextController.clear();
                                  controller.priceEditTextController.clear();
                                  controller.images.value = [];
                                } else {
                                  controller.showLoadingBar(false);
                                  Get.showSnackbar(const GetSnackBar(
                                    message: 'Something went wrong',
                                  ));
                                  // CustomToast.showToast('Something went wrong');
                                }
                              }
                            })
                        : const CircularProgressIndicator(
                            color: CustomColors.prime_color,
                          ),
                  );
                }),
              ],
            ),
          ))),
    );
  }

  Future<void> showCitiesListDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
              'Select City'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                const Text(""),
                Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: Get.put(CityController()).cityList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              String cityName = Get.put(CityController())
                                  .cityList[index]
                                  .cityname!
                                  .tr;
                              Get.put(AddPropertyController())
                                  .selectedCity
                                  .value = cityName;
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Get.put(CityController()).cityList[index].cityname!.tr}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  const Icon(
                                    Icons.location_city,
                                    color: CustomColors.prime_color,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ],
            )));
      },
    );
  }

  Future<void> showService(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Get.put(AddPropertyController);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Select Service'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Obx(() {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: Get.put(catogryController()).catogryList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            String valName = Get.put(catogryController())
                                .catogryList[index]
                                .catogryname!
                                .tr;
                            Get.put(AddPropertyController())
                                .selectedValue
                                .value = valName;
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${Get.put(catogryController()).catogryList[index].catogryname!.tr}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                const Icon(
                                  Icons.design_services,
                                  color: CustomColors.prime_color,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
        );
      },
    );
  }
}

// showDialog(
//   context: context,
//   builder: (context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose a service',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 3 / 2,
//                 mainAxisSpacing: 16.0,
//                 crossAxisSpacing: 16.0,
//               ),
//               itemCount: controller.values.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     String serviceName = controller.values[index];
//                     controller.selectedValue.value = serviceName;
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 4.0,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.work,
//                           color: CustomColors.orangeColor,
//                         ),
//                         SizedBox(width: 16.0),
//                         Expanded(
//                           child: Text(
//                             '${controller.values[index]}',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );
