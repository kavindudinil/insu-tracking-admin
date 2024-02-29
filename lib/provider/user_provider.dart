import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late String id;
  late String? username;
  late String email;
  late String? photoUrl;

  static final UserProvider instance = UserProvider._internal();

  factory UserProvider() => instance;

  UserProvider._internal();

  // UserProvider({
  //   this.id = '',
  //   this.username = '',
  //   this.email = '',
  //   this.photoUrl = '',
  // });

  void updateUserInfo({
    required String id,
    required String? username,
    required String email,
    required String? photoUrl,
  }) async {
    this.id = id;
    this.username = username;
    this.email = email;
    this.photoUrl = photoUrl;
    notifyListeners();
  }

}