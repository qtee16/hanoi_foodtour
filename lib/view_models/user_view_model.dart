import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  UserViewModel({required this.generalRepo});

  Future<User?> getUserById(String userId) async {
    return await generalRepo.getUserById(userId);
  }
}