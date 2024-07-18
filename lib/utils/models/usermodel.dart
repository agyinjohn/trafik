import 'dart:convert';

enum UserRole { admin, agent, user }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileUrl;
  // final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    // required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profileUrl': profileUrl,
      // 'role': role.toString().split('.').last,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] as String,
      // role: UserRole.values
      // .firstWhere((e) => e.toString().split('.').last == map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
