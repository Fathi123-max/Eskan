// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PropertyModel {
  String? username;

  String? usernumber;

  String? date;

  String? action;

  String? docId;

  String? currentUserId;

  String? propertyType;

  String? propertyFor;

  String? city;

  String? area;

  String? address;

  String? size;

  String? bedrooms;

  String? bathrooms;

  String? kitchen;

  String? descr;

  String? price;

  List? images;

  PropertyModel({
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
    List? images,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'usernumber': usernumber,
      'date': date,
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
      username: map['username'] != null ? map['username'] : null,
      usernumber: map['usernumber'] != null ? map['usernumber'] : null,
      date: map['date'] != null ? map['date'] : null,
      action: map['action'] != null ? map['action'] : null,
      docId: map['docId'] != null ? map['docId'] : null,
      currentUserId: map['currentUserId'] != null ? map['currentUserId'] : null,
      propertyType: map['propertyType'] != null ? map['propertyType'] : null,
      propertyFor: map['propertyFor'] != null ? map['propertyFor'] : null,
      city: map['city'] != null ? map['city'] : null,
      area: map['area'] != null ? map['area'] : null,
      address: map['address'] != null ? map['address'] : null,
      size: map['size'] != null ? map['size'] : null,
      bedrooms: map['bedrooms'] != null ? map['bedrooms'] : null,
      bathrooms: map['bathrooms'] != null ? map['bathrooms'] : null,
      kitchen: map['kitchen'] != null ? map['kitchen'] : null,
      descr: map['descr'] != null ? map['descr'] : null,
      price: map['price'] != null ? map['price'] : null,
      images: map['images'] != null ? map['images'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyModel.fromJson(String source) =>
      PropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PropertyModel(username: $username, usernumber: $usernumber, timestamp: $date, action: $action, docId: $docId, currentUserId: $currentUserId, propertyType: $propertyType, propertyFor: $propertyFor, city: $city, area: $area, address: $address, size: $size, bedrooms: $bedrooms, bathrooms: $bathrooms, kitchen: $kitchen, descr: $descr, price: $price, images: $images)';
  }

  @override
  bool operator ==(covariant PropertyModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.usernumber == usernumber &&
        other.date == date &&
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
        date.hashCode ^
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

  // Convert the list of PropertyModel objects to a JSON string
  static String toListJson(List<PropertyModel> list) {
    final List<Map<String, dynamic>> jsonList = list.map((item) {
      return item.toMap();
    }).toList();

    return json.encode(jsonList);
  }

  // Convert a JSON string to a list of PropertyModel objects
  static List<PropertyModel> fromListJson(String jsonList) {
    final List<dynamic> dynamicList = json.decode(jsonList);
    return dynamicList
        .map((item) => PropertyModel.fromJson(json.encode(item)))
        .toList();
  }
}
