// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  dynamic currentUserId;
  String firstName;
  String lastName;
  String userEmail;
  String userPassword;
  String phoneNumber;

  UserModel({
    this.currentUserId,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.userPassword,
    required this.phoneNumber,
  });
}
