import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({required this.id, required this.name, required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
    : this(id: json['id'], name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};

  factory UserModel.fromFirebaseUser(User? user) {
    if (user == null) {
      return UserModel(id: '', name: '', email: '');
    }
    return UserModel(
      id: user.uid,
      email: user.email.toString(),
      name: user.displayName.toString(),
    );
  }
}
