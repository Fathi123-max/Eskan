import 'package:get/get.dart';

import '../../models/used/propertyModel.dart';

class FavoriteController extends GetxController {
  // Add an observable property to track favorites.
  var favorites = <PropertyModel>[].obs;

  // Add methods to add/remove favorites.
  void addToFavorites(PropertyModel property) {
    favorites.add(property);
    property.addToFavorites();
  }

  void removeFromFavorites(PropertyModel property) {
    favorites.remove(property);
    property.removeFromFavorites();
  }

  bool isFavorite(PropertyModel property) {
    return favorites.contains(property);
  }
}
