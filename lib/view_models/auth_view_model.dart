import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  AuthViewModel({required this.generalRepo});

  User? _currentUser;
  String? _token;

  User? get currentUser => _currentUser;

  String? get token => _token;

  bool get isLogin => _currentUser != null;

  Future<void> setTokenFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    var dataEncode = prefs.getString("user_data");
    if (dataEncode != null) {
      var userData = json.decode(dataEncode);
      _token = userData["token"];
      print(_token);
      notifyListeners();
    }
  }

  Future<void> fetchCurrentUser() async {
    final user = await generalRepo.fetchCurrentUser();
    if (user != null) {
      await setCurrentUser(user);
    }
  }

  setCurrentUser(User? user) async {
    _currentUser = user;
    await setTokenFromLocal();
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await generalRepo.signUp(
      name: name,
      email: email,
      password: password,
    );
    setCurrentUser(user);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final user = await generalRepo.signIn(
      email: email,
      password: password,
    );
    setCurrentUser(user);
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _token = null;
    setCurrentUser(null);
  }
}
