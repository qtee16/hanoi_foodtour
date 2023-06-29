import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/rating.dart';
import '../repositories/general_repo.dart';

class FoodViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  FoodViewModel({required this.generalRepo});

  Future<Food> createFood(Map<String, dynamic> data, String? token) async {
    return await generalRepo.createFood(data, token);
  }

  Future<List<Food>> getTopRatingFoods(int limit, {int page = 0}) async {
    return await generalRepo.getTopRatingFoods(limit, page: page);
  }

  Future<void> ratingFood(Map<String, dynamic> data, String token) async {
    await generalRepo.ratingFood(data, token);
  }

  Future<Rating?> getMyFoodRating(
    String userId,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await generalRepo.getMyFoodRating(userId, data, token);
  }

  Future<List<Rating>> getAllFoodRating(Map<String, dynamic> data) async {
    return await generalRepo.getAllFoodRating(data);
  }
}
