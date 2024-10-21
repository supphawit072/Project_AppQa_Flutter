import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _accessToken;
  String? _refreshToken;

  User? get user => _user;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void setUser(UserModel userModel) {
    _user = userModel.user;
    _accessToken = userModel.accessToken;
    _refreshToken = userModel.refreshToken;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  void updateAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }
}
