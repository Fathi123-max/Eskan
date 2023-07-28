import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/used/propertyModel.dart';

class FavoritesController extends GetxController {
  final String _favoritesKey = 'favorites';
  final RxList<PropertyModel> favorites = <PropertyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson != null) {
      final favoritesList = PropertyModel.fromListJson(favoritesJson);
      favorites.assignAll(favoritesList);
    }
  }

  bool isFavorite(String docId) {
    return favorites.any((model) => model.currentUserId == docId);
  }

  void addToFavorites(PropertyModel property) async {
    favorites.add(property);
    await saveFavorites();
  }

  void removeFromFavorites(PropertyModel property) async {
    favorites.remove(property);
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = PropertyModel.toListJson(favorites);
    prefs.setString(_favoritesKey, favoritesJson);
  }
}
