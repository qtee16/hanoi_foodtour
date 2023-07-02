import 'package:flutter/material.dart';

import '../models/food.dart';
import '../models/rating.dart';
import '../repositories/general_repo.dart';

class FoodViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  FoodViewModel({required this.generalRepo});

  List<Food> _reviewedFoods = [];

  List<Food> get reviewedFoods => _reviewedFoods;

  Future<void> createFood(Map<String, dynamic> data, String? token) async {
    Food food = await generalRepo.createFood(data, token);
    _reviewedFoods.insert(0, food);
    notifyListeners();
  }

  Future<Food> getFoodById(String foodId) async {
    return await generalRepo.getFoodById(foodId);
  }

  Future<List<Food>> getTopRatingFoods(int limit, {int page = 0}) async {
    return await generalRepo.getTopRatingFoods(limit, page: page);
  }

  Future<void> getAllReviewedFood(String userId, String token) async {
    final result = await generalRepo.getAllReviewedFood(userId, token);
    _reviewedFoods = List.from(result);
    notifyListeners();
  }

  Future<void> updateFood(
    String foodId,
    Map<String, dynamic> data,
    String token,
  ) async {
    Food food = await generalRepo.updateFood(foodId, data, token);
    int index = _reviewedFoods.indexWhere((element) => element.id == foodId);
    _reviewedFoods.removeAt(index);
    _reviewedFoods.insert(index, food);
    notifyListeners();
  }

  Future<void> deleteFood(
    String foodId,
    String userId,
    String token,
  ) async {
    await generalRepo.deleteFood(foodId, userId, token);
    _reviewedFoods.removeWhere((element) => element.id == foodId);
    notifyListeners();
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
