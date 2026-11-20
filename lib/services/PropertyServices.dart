import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/models/used/cityModel.dart';
import 'package:haider/models/used/propertyModel.dart';

import '../models/used/catogrymodel.dart';

class PropertyServices {
  final box = GetStorage();
  CollectionReference property =
      FirebaseFirestore.instance.collection('property');

  /// Add property to Firestore with a proper auto-generated document ID.
  /// Returns the document ID on success, or an error message on failure.
  Future<String> addproprtyToDatabase(
    PropertyModel propertyModel,
    List images,
  ) async {
    // Validate required fields before uploading
    if (images.isEmpty) {
      return 'No images provided';
    }
    if (propertyModel.address == null ||
        propertyModel.address!.trim().isEmpty) {
      return 'Address is required';
    }
    if (propertyModel.city == null ||
        propertyModel.city!.trim().isEmpty) {
      return 'City is required';
    }
    if (propertyModel.area == null ||
        propertyModel.area!.trim().isEmpty) {
      return 'Area is required';
    }
    if (propertyModel.size == null ||
        propertyModel.size!.trim().isEmpty) {
      return 'Size is required';
    }
    if (propertyModel.bedrooms == null ||
        propertyModel.bedrooms!.trim().isEmpty) {
      return 'Bedrooms are required';
    }
    if (propertyModel.price == null ||
        propertyModel.price!.trim().isEmpty) {
      return 'Price is required';
    }

    // Validate numeric fields
    final priceValue = int.tryParse(propertyModel.price!);
    if (priceValue == null || priceValue < 0) {
      return 'Invalid price value';
    }
    final bedroomsValue = int.tryParse(propertyModel.bedrooms!);
    if (bedroomsValue == null || bedroomsValue < 0) {
      return 'Invalid bedrooms value';
    }
    final bathroomsValue = int.tryParse(propertyModel.bathrooms ?? '');
    if (bathroomsValue == null || bathroomsValue < 0) {
      return 'Invalid bathrooms value';
    }
    final kitchenValue = int.tryParse(propertyModel.kitchen ?? '');
    if (kitchenValue == null || kitchenValue < 0) {
      return 'Invalid kitchen value';
    }
    final sizeValue = int.tryParse(propertyModel.size!);
    if (sizeValue == null || sizeValue < 0) {
      return 'Invalid size value';
    }

    // Upload images to Firebase Storage
    List<String> imageUrls = [];
    bool uploadFailed = false;

    for (int i = 0; i < images.length; i++) {
      try {
        final asset = images[i];
        final byteData = await asset.getByteData(quality: 20);
        if (byteData == null) {
          print('Warning: Could not get byte data for image $i, skipping');
          continue;
        }
        final fileName =
            'RealState/${DateTime.now().millisecondsSinceEpoch}_$i';
        final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

        await firebaseStorageRef.putData(
          byteData.buffer.asUint8List(),
        );

        final url = await firebaseStorageRef.getDownloadURL();
        imageUrls.add(url);
        print('Image $i uploaded successfully');
      } catch (e) {
        print('Error uploading image $i: $e');
        uploadFailed = true;
        // Continue with other images instead of failing the entire upload
      }
    }

    if (imageUrls.isEmpty) {
      return 'No images were uploaded successfully';
    }

    // Prepare property data
    final docRef = property.doc(); // Auto-generated document ID
    final now = DateTime.now();

    propertyModel.docId = docRef.id;
    // Use Firebase Auth UID as the owner identifier if available, otherwise fall back to storage
    propertyModel.currentUserId =
        box.read('userId') ?? propertyModel.currentUserId ?? '';
    propertyModel.username = box.read('name');
    propertyModel.usernumber = box.read('phone');
    propertyModel.date = Timestamp.fromDate(now).toDate().toString();
    propertyModel.images = imageUrls;

    // Write to Firestore
    try {
      await docRef.set(propertyModel.toMap());
      print('Property saved with docId: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('Error saving property to Firestore: $e');
      // Clean up uploaded images if Firestore write fails
      for (final url in imageUrls) {
        try {
          final storageRef = FirebaseStorage.instance.refFromURL(url);
          await storageRef.delete();
        } catch (_) {
          // Ignore cleanup errors
        }
      }
      return 'Error saving property: $e';
    }
  }

  /// Get all categories from Firestore
  Stream<List<Category>> getAllCategories() {
    return FirebaseFirestore.instance.collection('catogry').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Category.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Get all cities from Firestore
  Stream<List<CityModel>> getAllCities() {
    return FirebaseFirestore.instance.collection('city').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => CityModel.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Get all properties for sale with consistent pagination
  Future<List<PropertyModel>> getAllBuyingList({int limit = 20}) async {
    final propertyList = <PropertyModel>[];
    final querySnapshot = await FirebaseFirestore.instance
        .collection('property')
        .where('propertyFor', isEqualTo: 'sale')
        .limit(limit)
        .get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      // Only include documents that have the propertyFor field set to 'sale'
      if (data['propertyFor'] == 'sale') {
        propertyList.add(PropertyModel.fromMap(data));
      }
    }
    return propertyList;
  }

  /// Get the base query for pagination (used by FirestoreListView)
  Query get propertyQuery => property;

  /// Get recent properties for rent with consistent pagination
  Future<List<PropertyModel>> getAllRentList({int limit = 20}) async {
    final propertyList = <PropertyModel>[];
    final querySnapshot = await FirebaseFirestore.instance
        .collection('property')
        .where('propertyFor', isEqualTo: 'rent')
        .limit(limit)
        .get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data['propertyFor'] == 'rent') {
        propertyList.add(PropertyModel.fromMap(data));
      }
    }
    return propertyList;
  }

  /// Get properties by category/type
  Future<List<PropertyModel>> getAllRentListByCategory(
      {String? category}) async {
    if (category == null || category.isEmpty) {
      return [];
    }

    final propertyList = <PropertyModel>[];
    final querySnapshot = await FirebaseFirestore.instance
        .collection('property')
        .where('propertyType', isEqualTo: category)
        .limit(50)
        .get();

    for (final doc in querySnapshot.docs) {
      propertyList.add(PropertyModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return propertyList;
  }

  /// Update a property's action status (e.g., 'Sold Out', 'Rented')
  Future<String> updateProperty(String docId, String updatedValue) async {
    if (docId.isEmpty) {
      return 'Invalid document ID';
    }

    try {
      await property.doc(docId).update({
        'propertyAction': updatedValue.toString(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return 'Data Updated';
    } catch (e) {
      return 'Failed to update property: $e';
    }
  }

  /// Delete a property and its images from storage
  Future<String> deleteProperty(String docId, List images) async {
    if (docId.isEmpty) {
      return 'Invalid document ID';
    }

    // Delete images from Firebase Storage
    for (final imageUrl in images) {
      try {
        final storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
        await storageReference.delete();
        print('Image deleted: $imageUrl');
      } catch (e) {
        print('Error deleting image $imageUrl: $e');
        // Continue with other images even if one fails
      }
    }

    // Delete the Firestore document
    try {
      await property.doc(docId).delete();
      return 'Property Deleted';
    } catch (e) {
      return 'Failed to Delete Property: $e';
    }
  }

  /// Get current user's properties for rent out
  Future<List<PropertyModel>> getCurrentUserPropertyForRentOut() async {
    final propertyName = box.read('name');
    final propertyPhone = box.read('phone');

    if (propertyName == null || propertyPhone == null) {
      return [];
    }

    final propertyList = <PropertyModel>[];
    final querySnapshot = await property
        .where('username', isEqualTo: propertyName)
        .where('usernumber', isEqualTo: propertyPhone)
        .limit(50)
        .get();

    for (final doc in querySnapshot.docs) {
      propertyList.add(PropertyModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return propertyList;
  }

  /// Get current user's properties for selling
  Future<List<PropertyModel>> getCurrentUserPropertyForSelling() async {
    final propertyName = box.read('name');
    final propertyPhone = box.read('phone');

    if (propertyName == null || propertyPhone == null) {
      return [];
    }

    final propertyList = <PropertyModel>[];
    final querySnapshot = await property
        .where('username', isEqualTo: propertyName)
        .where('usernumber', isEqualTo: propertyPhone)
        .where('propertyFor', isEqualTo: 'sale')
        .limit(50)
        .get();

    for (final doc in querySnapshot.docs) {
      propertyList.add(PropertyModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return propertyList;
  }

  /// Search properties for rent with server-side filtering
  Future<List<PropertyModel>> searchRentList({
    String? cityName,
    int? priceFrom,
    int? priceTo,
  }) async {
    return _searchProperties(
      propertyFor: 'rent',
      cityName: cityName,
      priceFrom: priceFrom,
      priceTo: priceTo,
    );
  }

  /// Search properties for sale with server-side filtering
  Future<List<PropertyModel>> searchBuyList({
    String? cityName,
    int? priceFrom,
    int? priceTo,
  }) async {
    return _searchProperties(
      propertyFor: 'sale',
      cityName: cityName,
      priceFrom: priceFrom,
      priceTo: priceTo,
    );
  }

  /// Core search method with server-side filtering
  Future<List<PropertyModel>> _searchProperties({
    required String propertyFor,
    String? cityName,
    int? priceFrom,
    int? priceTo,
    int limit = 50,
  }) async {
    Query query = property.where('propertyFor', isEqualTo: propertyFor);

    // Add city filter if provided
    if (cityName != null && cityName.isNotEmpty) {
      query = query.where('city', isEqualTo: cityName);
    }

    // Add price range filters if provided
    if (priceFrom != null && priceFrom > 0) {
      query = query.where('price', isGreaterThanOrEqualTo: priceFrom);
    }
    if (priceTo != null && priceTo > 0) {
      query = query.where('price', isLessThanOrEqualTo: priceTo);
    }

    // Always apply a limit
    query = query.limit(limit);

    // Order by price descending for consistent results
    query = query.orderBy('price', descending: true);

    final querySnapshot = await query.get();
    final propertyList = <PropertyModel>[];

    for (final doc in querySnapshot.docs) {
      propertyList.add(PropertyModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return propertyList;
  }

  /// Search properties by text (area name)
  Future<List<PropertyModel>> searchByArea(String areaText) async {
    if (areaText.isEmpty) {
      return [];
    }

    final propertyList = <PropertyModel>[];
    final querySnapshot = await property
        .where('area', isGreaterThanOrEqualTo: areaText)
        .where('area', isLessThan: areaText + 'z')
        .limit(50)
        .get();

    for (final doc in querySnapshot.docs) {
      propertyList.add(PropertyModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return propertyList;
  }
}
