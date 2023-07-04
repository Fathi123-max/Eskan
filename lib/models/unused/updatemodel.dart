// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class updateModel {
  String? urlOfApp;
  String? message;
  bool? isupdateFound;
  updateModel({
    this.urlOfApp,
    this.message,
    this.isupdateFound,
  });

  updateModel copyWith({
    String? urlOfApp,
    String? message,
    bool? isupdateFound,
  }) {
    return updateModel(
      urlOfApp: urlOfApp ?? this.urlOfApp,
      message: message ?? this.message,
      isupdateFound: isupdateFound ?? this.isupdateFound,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'urlOfApp': urlOfApp,
      'message': message,
      'isupdateFound': isupdateFound,
    };
  }

  factory updateModel.fromMap(Map<String, dynamic> map) {
    return updateModel(
      urlOfApp: map['urlOfApp'] != null ? map['urlOfApp'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      isupdateFound:
          map['isupdateFound'] != null ? map['isupdateFound'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory updateModel.fromJson(String source) =>
      updateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'updateModel(urlOfApp: $urlOfApp, message: $message, isupdateFound: $isupdateFound)';

  @override
  bool operator ==(covariant updateModel other) {
    if (identical(this, other)) return true;

    return other.urlOfApp == urlOfApp &&
        other.message == message &&
        other.isupdateFound == isupdateFound;
  }

  @override
  int get hashCode =>
      urlOfApp.hashCode ^ message.hashCode ^ isupdateFound.hashCode;
}
