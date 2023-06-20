// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? catogryname;
  String? catogryimage;
  User({
    this.catogryname,
    this.catogryimage,
  });

  User copyWith({
    String? catogryname,
    String? catogryimage,
  }) {
    return User(
      catogryname: catogryname ?? this.catogryname,
      catogryimage: catogryimage ?? this.catogryimage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'catogryname': catogryname,
      'catogryimage': catogryimage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      catogryname:
          map['catogryname'] != null ? map['catogryname'] as String : null,
      catogryimage:
          map['catogryimage'] != null ? map['catogryimage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'catogrumodel(catogryname: $catogryname, catogryimage: $catogryimage)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.catogryname == catogryname &&
        other.catogryimage == catogryimage;
  }

  @override
  int get hashCode => catogryname.hashCode ^ catogryimage.hashCode;
}
