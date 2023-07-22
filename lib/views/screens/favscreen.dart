import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/rentviewcard.dart';
import 'package:hive/hive.dart';

import '../../controllers/used/favourateController.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Box<PropertyModel> _favoritesBox;
  List<PropertyModel> _favoriteProperties = []; // Initialize the list here
  final FavoriteController favoriteController = Get.find();

  @override
  void initState() {
    super.initState();
    _favoritesBox = Hive.box<PropertyModel>('favorites');
    _favoriteProperties = _favoritesBox.values.toList().cast<PropertyModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: _favoriteProperties.isEmpty
          ? Center(child: Text('No favorite properties'))
          : ListView.builder(
              itemCount: _favoriteProperties.length,
              itemBuilder: (context, index) {
                return RealViewCard(
                  property: _favoriteProperties[index],
                  favoriteController: favoriteController,
                );
              },
            ),
    );
  }
}
