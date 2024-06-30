// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'profileUrl': profileUrl};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      profileUrl: map['profileUrl'],
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
