import 'package:flutter/material.dart';

import '../../models/used/propertyModel.dart';

class SuccessScreen extends StatelessWidget {
  final PropertyModel property;

  SuccessScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
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
              'Property Added Successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Display property details
            Text('Property Type: ${property.propertyType ?? ''}'),
            Text('Address: ${property.address ?? ''}'),
            // Add other details you want to display
            // You can customize the UI as per your requirements
          ],
        ),
      ),
    );
  }
}
