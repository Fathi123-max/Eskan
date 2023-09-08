import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/rentviewcard.dart';

class SearchResultPage extends GetView {
  const SearchResultPage({required this.query});
  final Query<Map<String, dynamic>> query;

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
      body: FirestoreListView<Map<String, dynamic>>(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        addSemanticIndexes: true,
        physics: BouncingScrollPhysics(),
        query: query,
        itemBuilder: (context, snapshot) {
          final property = PropertyModel.fromMap(snapshot.data());
          return RealViewCard(
            property: property,
          );
        },
      ),
    );
  }
}
