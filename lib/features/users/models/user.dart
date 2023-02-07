import 'package:mobilapp/common/models/role.dart';

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final Role role;
  final String? google_id;

  User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.role,
      this.google_id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      role: Role.fromJson(json['role']),
      google_id: json['google_id'],
    );
  }
}
