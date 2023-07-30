import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/used/propertyModel.dart';
import 'homeView.dart';

class SuccessScreen extends StatelessWidget {
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
            SizedBox(height: 10),
            // Display property details
            ElevatedButton(
                onPressed: () {
                  Get.offAll(() => Home());
                },
                child: Text("الرئيسية"))
            // Add other details you want to display
            // You can customize the UI as per your requirements
          ],
        ),
      ),
    );
  }
}
