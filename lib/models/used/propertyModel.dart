// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Supported property listing types.
enum PropertyFor { sale, rent }

/// Extension for [PropertyFor] enum serialization.
extension PropertyForExtension on PropertyFor {
  /// Converts enum to its string representation.
  String get value => switch (this) {
        PropertyFor.sale => 'sale',
        PropertyFor.rent => 'rent',
      };

  /// Creates enum from string value (case-insensitive).
  static PropertyFor fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'sale' => PropertyFor.sale,
      'rent' => PropertyFor.rent,
      _ => PropertyFor.rent, // Default to rent for backward compatibility
    };
  }
}

/// Model representing a property listing.
/// Used for both rental and sale properties.
class PropertyModel {
  /// Owner's display name
  final String? username;

  /// Owner's phone number
  final String? usernumber;

  /// Listing date/time
  final String? date;

  /// Property action status (e.g., 'active', 'sold', 'rented')
  final String? action;

  /// Firestore document ID
  final String? docId;

  /// Current user ID (Firebase Auth UID)
  final String? currentUserId;

  /// Property category/type (e.g., 'Apartment', 'Villa')
  final String? propertyType;

  /// Whether the property is for sale or rent
  final String? propertyFor;

  /// City name
  final String? city;

  /// Area/neighborhood name
  final String? area;

  /// Full address
  final String? address;

  /// Size in square meters
  final String? size;

  /// Number of bedrooms
  final String? bedrooms;

  /// Number of bathrooms
  final String? bathrooms;

  /// Number of kitchens
  final String? kitchen;

  /// Property description
  final String? descr;

  /// Price in currency units (EGP)
  final String? price;

  /// List of image URLs
  final List<String>? images;

  /// Returns the first image URL if available, otherwise null.
  /// Use this everywhere instead of [images]![0] to avoid crashes.
  String? get firstImageUrl =>
      images?.isNotEmpty == true ? images!.first : null;

  /// Creates a [PropertyModel] instance.
  const PropertyModel({
    this.username,
    this.usernumber,
    this.date,
    this.action,
    this.docId,
    this.currentUserId,
    this.propertyType,
    this.propertyFor,
    this.city,
    this.area,
    this.address,
    this.size,
    this.bedrooms,
    this.bathrooms,
    this.kitchen,
    this.descr,
    this.price,
    this.images,
  });

  /// Creates a copy of this model with optional new values.
  PropertyModel copyWith({
    String? username,
    String? usernumber,
    String? date,
    String? action,
    String? docId,
    String? currentUserId,
    String? propertyType,
    String? propertyFor,
    String? city,
    String? area,
    String? address,
    String? size,
    String? bedrooms,
    String? bathrooms,
    String? kitchen,
    String? descr,
    String? price,
    List<String>? images,
  }) {
    return PropertyModel(
      username: username ?? this.username,
      usernumber: usernumber ?? this.usernumber,
      date: date ?? this.date,
      action: action ?? this.action,
      docId: docId ?? this.docId,
      currentUserId: currentUserId ?? this.currentUserId,
      propertyType: propertyType ?? this.propertyType,
      propertyFor: propertyFor ?? this.propertyFor,
      city: city ?? this.city,
      area: area ?? this.area,
      address: address ?? this.address,
      size: size ?? this.size,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      kitchen: kitchen ?? this.kitchen,
      descr: descr ?? this.descr,
      price: price ?? this.price,
      images: images ?? this.images,
    );
  }

  /// Converts this model to a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (username != null) 'username': username,
      if (usernumber != null) 'usernumber': usernumber,
      if (date != null) 'date': date,
      if (action != null) 'action': action,
      if (docId != null) 'docId': docId,
      if (currentUserId != null) 'currentUserId': currentUserId,
      if (propertyType != null) 'propertyType': propertyType,
      if (propertyFor != null) 'propertyFor': propertyFor,
      if (city != null) 'city': city,
      if (area != null) 'area': area,
      if (address != null) 'address': address,
      if (size != null) 'size': size,
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (kitchen != null) 'kitchen': kitchen,
      if (descr != null) 'descr': descr,
      if (price != null) 'price': price,
      if (images != null) 'images': images,
    };
  }

  /// Creates a [PropertyModel] from a Firestore document map.
  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      username: map['username'] as String?,
      usernumber: map['usernumber'] as String?,
      date: map['date'] as String?,
      action: map['action'] as String?,
      docId: map['docId'] as String?,
      currentUserId: map['currentUserId'] as String?,
      propertyType: map['propertyType'] as String?,
      propertyFor: map['propertyFor'] as String?,
      city: map['city'] as String?,
      area: map['area'] as String?,
      address: map['address'] as String?,
      size: map['size'] as String?,
      bedrooms: map['bedrooms'] as String?,
      bathrooms: map['bathrooms'] as String?,
      kitchen: map['kitchen'] as String?,
      descr: map['descr'] as String?,
      price: map['price'] as String?,
      images: map['images'] as List<String>?,
    );
  }

  /// Converts this model to a JSON string.
  String toJson() => json.encode(toMap());

  /// Creates a [PropertyModel] from a JSON string.
  factory PropertyModel.fromJson(String source) =>
      PropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Returns a string representation of this model for debugging.
  @override
  String toString() {
    return 'PropertyModel(
      username: $username,
      city: $city,
      area: $area,
      address: $address,
      propertyFor: $propertyFor,
      price: $price,
      images: ${images?.length ?? 0} images
    )';
  }

  /// Equality comparison based on all properties.
  @override
  bool operator ==(covariant PropertyModel other) {
    if (identical(this, other)) return true;
    if (other is! PropertyModel) return false;

    return username == other.username &&
        usernumber == other.usernumber &&
        date == other.date &&
        action == other.action &&
        docId == other.docId &&
        currentUserId == other.currentUserId &&
        propertyType == other.propertyType &&
        propertyFor == other.propertyFor &&
        city == other.city &&
        area == other.area &&
        address == other.address &&
        size == other.size &&
        bedrooms == other.bedrooms &&
        bathrooms == other.bathrooms &&
        kitchen == other.kitchen &&
        descr == other.descr &&
        price == other.price &&
        images == other.images;
  }

  /// Hash code for this model.
  @override
  int get hashCode {
    return Object.hash(
      username,
      usernumber,
      date,
      action,
      docId,
      currentUserId,
      propertyType,
      propertyFor,
      city,
      area,
      address,
      size,
      bedrooms,
      bathrooms,
      kitchen,
      descr,
      price,
      images,
    );
  }

  /// Converts a list of [PropertyModel] to a JSON string.
  static String toListJson(List<PropertyModel> list) {
    final jsonList = list.map((item) => item.toMap()).toList();
    return json.encode(jsonList);
  }

  /// Creates a list of [PropertyModel] from a JSON string.
  static List<PropertyModel> fromListJson(String jsonList) {
    final dynamicList = json.decode(jsonList) as List<dynamic>;
    return dynamicList
        .map((item) => PropertyModel.fromJson(json.encode(item)))
        .toList();
  }
}
