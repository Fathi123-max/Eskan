// ignore_for_file: public_member_api_docs
import 'dart:convert';

/// Model representing a city.
class CityModel {
  /// City name
  final String? cityname;

  /// Creates a [CityModel] instance.
  const CityModel({this.cityname});

  /// Creates a copy of this model with optional new values.
  CityModel copyWith({String? cityname}) {
    return CityModel(cityname: cityname ?? this.cityname);
  }

  /// Converts this model to a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (cityname != null) 'cityname': cityname,
    };
  }

  /// Creates a [CityModel] from a Firestore document map.
  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      cityname: map['cityname'] as String?,
    );
  }

  /// Converts this model to a JSON string.
  String toJson() => json.encode(toMap());

  /// Creates a [CityModel] from a JSON string.
  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Returns a string representation for debugging.
  @override
  String toString() => 'CityModel(cityname: $cityname)';

  /// Equality comparison.
  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;
    if (other is! CityModel) return false;
    return cityname == other.cityname;
  }

  /// Hash code.
  @override
  int get hashCode => Object.hash(cityname);
}
