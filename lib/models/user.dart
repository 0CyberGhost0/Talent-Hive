import 'dart:convert';

class User {
  final String name;
  final String id;
  final String email;
  final String password;
  final String token;
  final List<String> skills;
  User({
    required this.skills,
    required this.name,
    required this.id,
    required this.email,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'password': password,
      'token': token,
      'skills': skills,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      skills: map['skills'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
