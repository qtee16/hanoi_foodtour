import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

import '../models/comment.dart';

class CommentViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  CommentViewModel({required this.generalRepo});

  Future<Comment> sendComment(String type, Map<String, dynamic> data, String restaurantId, String token) async {
    return await generalRepo.sendComment(type, data, restaurantId, token);
  }

  Future<List<Comment>> getComment(String type, String restaurantId, int limit, {int page = 0}) async {
    return await generalRepo.getComment(type, restaurantId, limit, page: page);
  }
}