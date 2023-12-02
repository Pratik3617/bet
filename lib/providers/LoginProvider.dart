import 'package:flutter/material.dart';

class User {
  final String username;

  User({required this.username});
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(String username) {
    _user = User(username: username);
    notifyListeners();
  }
}
