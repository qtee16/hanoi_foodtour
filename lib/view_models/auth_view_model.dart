import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLogin => _currentUser != null;

  AuthViewModel({required this.generalRepo});

  Future<void> fetchCurrentUser() async {
    final userMap = await generalRepo.fetchCurrentUser();
    if (userMap != null) {
      setCurrentUser(User.fromJson(userMap));
    }
  }

  setCurrentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final userMap = await generalRepo.signUp(
      name: name,
      email: email,
      password: password,
    );
    setCurrentUser(User.fromJson(userMap));
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final userMap = await generalRepo.signIn(
      email: email,
      password: password,
    );
    print(userMap);
    setCurrentUser(User.fromJson(userMap));
  }

  Future<void> signOut() async {
    final refs = await SharedPreferences.getInstance();
    refs.clear();
    setCurrentUser(null);
  }
}
