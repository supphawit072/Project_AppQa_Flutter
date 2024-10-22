import 'package:flutter/material.dart';
import 'package:test/models/form_midel.dart';

class FormProvider extends ChangeNotifier {
  FormModel? _form;
  String? _accessToken;
  String? _refreshToken;

  // Getters to access the form and tokens
  FormModel? get form => _form;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  // Method to set the form and tokens
  void setForm(FormModel formModel, String accessToken, String refreshToken) {
    _form = formModel;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    notifyListeners();
  }

  // Method to clear the form and tokens
  void clearForm() {
    _form = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  // Method to update just the access token
  void updateAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }
}
