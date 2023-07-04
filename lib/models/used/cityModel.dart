// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CityModel {
  String? cityname;
  CityModel({
    this.cityname,
  });

  CityModel copyWith({
    String? cityname,
  }) {
    return CityModel(
      cityname: cityname ?? this.cityname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityname': cityname,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      cityname: map['cityname'] != null ? map['cityname'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CityModel(cityname: $cityname)';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.cityname == cityname;
  }

  @override
  int get hashCode => cityname.hashCode;
}
