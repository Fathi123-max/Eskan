import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/rentviewcard.dart';

class SearchResultPage extends GetView {
  SearchResultPage({required this.propertyModelList});

  List<PropertyModel> propertyModelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("نتائج البحث"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios_new)),
        ],
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: propertyModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 300,
            child: RealViewCard(
              property: propertyModelList[index],
            ),
          );
        },
      ),
    );
  }
}
