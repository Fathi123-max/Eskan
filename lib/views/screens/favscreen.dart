import 'package:flutter/material.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/rentviewcard.dart';
import 'package:hive/hive.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<List<PropertyModel>>? _futurePropertyModels;

  @override
  void initState() {
    super.initState();
    _futurePropertyModels = readData();
  }

  Future<List<PropertyModel>> readData() async {
    var favoritesBox = await Hive.openBox('favourites');
    return favoritesBox.values.whereType<PropertyModel>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<PropertyModel>>(
      future: _futurePropertyModels,
      builder:
          (BuildContext context, AsyncSnapshot<List<PropertyModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final propertyModels = snapshot.data;

        if (propertyModels == null || propertyModels.isEmpty) {
          return Center(child: Text('No data available'));
        }

        return ListView.builder(
          itemCount: propertyModels.length,
          itemBuilder: (BuildContext context, int index) {
            return RealViewCard(property: propertyModels[index]);
          },
        );
      },
    ));
  }
}
