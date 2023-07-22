// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'propertyModel.g.dart';

@HiveType(typeId: 1)
class PropertyModel {
  @HiveField(0)
  String? username;

  @HiveField(1)
  String? usernumber;

  @HiveField(2)
  Timestamp? timestamp;

  @HiveField(3)
  String? action;

  @HiveField(4)
  String? docId;

  @HiveField(5)
  String? currentUserId;

  @HiveField(6)
  String? propertyType;

  @HiveField(7)
  String? propertyFor;

  @HiveField(8)
  String? city;

  @HiveField(9)
  String? area;

  @HiveField(10)
  String? address;

  @HiveField(11)
  String? size;

  @HiveField(12)
  String? bedrooms;

  @HiveField(13)
  String? bathrooms;

  @HiveField(14)
  String? kitchen;

  @HiveField(15)
  String? descr;

  @HiveField(16)
  String? price;

  @HiveField(17)
  List? images;

  PropertyModel({
    this.username,
    this.usernumber,
    this.timestamp,
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

  PropertyModel copyWith({
    String? username,
    String? usernumber,
    Timestamp? timestamp,
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
    List? images,
  }) {
    return PropertyModel(
      username: username ?? this.username,
      usernumber: usernumber ?? this.usernumber,
      timestamp: timestamp ?? this.timestamp,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'usernumber': usernumber,
      'timestamp': timestamp,
      'action': action,
      'docId': docId,
      'currentUserId': currentUserId,
      'propertyType': propertyType,
      'propertyFor': propertyFor,
      'city': city,
      'area': area,
      'address': address,
      'size': size,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'kitchen': kitchen,
      'descr': descr,
      'price': price,
      'images': images,
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      username: map['username'] != null ? map['username'] as String : null,
      usernumber:
          map['usernumber'] != null ? map['usernumber'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] : null,
      action: map['action'] != null ? map['action'] as String : null,
      docId: map['docId'] != null ? map['docId'] as String : null,
      currentUserId:
          map['currentUserId'] != null ? map['currentUserId'] as String : null,
      propertyType:
          map['propertyType'] != null ? map['propertyType'] as String : null,
      propertyFor:
          map['propertyFor'] != null ? map['propertyFor'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      size: map['size'] != null ? map['size'] as String : null,
      bedrooms: map['bedrooms'] != null ? map['bedrooms'] as String : null,
      bathrooms: map['bathrooms'] != null ? map['bathrooms'] as String : null,
      kitchen: map['kitchen'] != null ? map['kitchen'] as String : null,
      descr: map['descr'] != null ? map['descr'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      images: map['images'] != null ? map['images'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyModel.fromJson(String source) =>
      PropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PropertyModel(username: $username, usernumber: $usernumber, timestamp: $timestamp, action: $action, docId: $docId, currentUserId: $currentUserId, propertyType: $propertyType, propertyFor: $propertyFor, city: $city, area: $area, address: $address, size: $size, bedrooms: $bedrooms, bathrooms: $bathrooms, kitchen: $kitchen, descr: $descr, price: $price, images: $images)';
  }

  @override
  bool operator ==(covariant PropertyModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.usernumber == usernumber &&
        other.timestamp == timestamp &&
        other.action == action &&
        other.docId == docId &&
        other.currentUserId == currentUserId &&
        other.propertyType == propertyType &&
        other.propertyFor == propertyFor &&
        other.city == city &&
        other.area == area &&
        other.address == address &&
        other.size == size &&
        other.bedrooms == bedrooms &&
        other.bathrooms == bathrooms &&
        other.kitchen == kitchen &&
        other.descr == descr &&
        other.price == price &&
        other.images == images;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        usernumber.hashCode ^
        timestamp.hashCode ^
        action.hashCode ^
        docId.hashCode ^
        currentUserId.hashCode ^
        propertyType.hashCode ^
        propertyFor.hashCode ^
        city.hashCode ^
        area.hashCode ^
        address.hashCode ^
        size.hashCode ^
        bedrooms.hashCode ^
        bathrooms.hashCode ^
        kitchen.hashCode ^
        descr.hashCode ^
        price.hashCode ^
        images.hashCode;
  }

  final favoritesBox = Hive.box('favorites');
// Inside PropertyModel class
  bool isFavorite() {
    return favoritesBox.containsKey(docId
        .toString()); // Assuming 'docId' is a unique identifier for the property.
  }

// Inside PropertyModel class
  void addToFavorites() {
    favoritesBox.put(docId.toString(), this);
  }

  void removeFromFavorites() {
    favoritesBox.delete(docId.toString());
  }
}
