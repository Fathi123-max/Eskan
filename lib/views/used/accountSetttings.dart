import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/currentUserInfoController.dart';
import 'package:haider/utills/customColors.dart';

class AccountSettings extends GetView {
  final CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new)),
        ],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => EnterInfo());
        },
        heroTag: "hellofrom 2dfdsjhfj",
        backgroundColor: CustomColors.prime_color,
        child: Icon(Icons.edit_outlined),
      ),
      body: Obx(() {
        if (currentUserInfoController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: [
              Image.asset(
                'assets/images/icon.png',
                // color: Colors.white,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 20, left: 8, bottom: 8),
                      child: Icon(
                        Icons.person_outline,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                        ),
                        Text(
                          box.read("name").toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 20, left: 8, bottom: 8),
                      child: Icon(
                        Icons.phone_android_outlined,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone'.tr,
                        ),
                        Text(
                          box.read("phone").toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
