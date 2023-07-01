import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

class LikeViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;
  LikeViewModel({required this.generalRepo});

  Future<Map<String, dynamic>> sendLike(String userId, String objectId, String type, String token) async {
    return await generalRepo.sendLike(userId, objectId, type, token);
  }

  Future<List> getAllLike(String objectId, String type) async {
    return await generalRepo.getAllLike(objectId, type);
  }
}