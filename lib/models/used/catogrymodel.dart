// ignore_for_file: public_member_api_docs
import 'dart:convert';

/// Represents a property category/type (e.g., "Apartment", "Villa", "Office").
class Category {
  /// Category name
  final String? catogryname;

  /// Category image URL
  final String? catogryimage;

  /// Creates a [Category] instance.
  const Category({this.catogryname, this.catogryimage});

  /// Creates a copy of this model with optional new values.
  Category copyWith({String? catogryname, String? catogryimage}) {
    return Category(
      catogryname: catogryname ?? this.catogryname,
      catogryimage: catogryimage ?? this.catogryimage,
    );
  }

  /// Converts this model to a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (catogryname != null) 'catogryname': catogryname,
      if (catogryimage != null) 'catogryimage': catogryimage,
    };
  }

  /// Creates a [Category] from a Firestore document map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      catogryname: map['catogryname'] as String?,
      catogryimage: map['catogryimage'] as String?,
    );
  }

  /// Converts this model to a JSON string.
  String toJson() => json.encode(toMap());

  /// Creates a [Category] from a JSON string.
  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Returns a string representation for debugging.
  @override
  String toString() =>
      'Category(catogryname: $catogryname, catogryimage: $catogryimage)';

  /// Equality comparison.
  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;
    if (other is! Category) return false;
    return catogryname == other.catogryname &&
        catogryimage == other.catogryimage;
  }

  /// Hash code.
  @override
  int get hashCode => Object.hash(catogryname, catogryimage);
}
