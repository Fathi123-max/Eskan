import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utills/customColors.dart';

class Choosetype extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fill))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Enter your information ",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
            child: InkWell(
              onTap: () {
                // Get.to(() => );
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.green_color,
                      border: Border.all(color: CustomColors.green_color),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                    'Next'.tr,
                    style: TextStyle(color: CustomColors.secondary_color),
                  ))),
            ),
          ),
        ],
      ),
    ));
  }
}
