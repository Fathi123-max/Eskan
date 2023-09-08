import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/used/propertyModel.dart';
import 'homeView.dart';

class SuccessScreen extends GetView {
  final PropertyModel property;

  SuccessScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('تم رفع العقار بنجاح '),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'تم رفع العقار بنجاح ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            // Display property details
            GestureDetector(
              onTap: () {
                Get.offAll(() => Home());
              },
              child: Container(
                margin: EdgeInsets.all(60),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "الرئيسية",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
            // Add other details you want to display
            // You can customize the UI as per your requirements
          ],
        ),
      ),
    );
  }
}
