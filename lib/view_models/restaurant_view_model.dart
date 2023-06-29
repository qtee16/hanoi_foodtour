import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

import '../models/food.dart';
import '../models/rating.dart';
import '../models/restaurant.dart';

class RestaurantViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  RestaurantViewModel({required this.generalRepo});

  List<Restaurant> _reviewedRestaurants = [];

  List<Restaurant> get reviewedRestaurants => _reviewedRestaurants;

  Future<void> createRestaurant(
    Map<String, dynamic> data,
    String? token,
  ) async {
    final restaurant = await generalRepo.createRestaurant(data, token);
    _reviewedRestaurants.insert(0, restaurant);
    notifyListeners();
  }

  Future<void> getAllReviewedRestaurant(String? token) async {
    final result = await generalRepo.getAllReviewedRestaurant(token);
    if (result != null) {
      _reviewedRestaurants = List.from(result);
      notifyListeners();
    }
  }

  Future<List<Restaurant>> getTopRatingRestaurants(int limit, {int page = 0}) async {
    return await generalRepo.getTopRatingRestaurants(limit, page: page);
  }

  Future<void> ratingRestaurant(Map<String, dynamic> data, String token) async {
    await generalRepo.ratingRestaurant(data, token);
  }

  Future<Rating?> getMyRestaurantRating(
    String userId,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await generalRepo.getMyRestaurantRating(userId, data, token);
  }

  Future<List<Rating>> getAllRestaurantRating(
    Map<String, dynamic> data,
  ) async {
    return await generalRepo.getAllRestaurantRating(data);
  }

  Future<Restaurant> getRestaurantById(String restaurantId) async {
    return await generalRepo.getRestaurantById(restaurantId);
  }

  Future<List<Food>> getAllFoodOfRestaurant(String restaurantId) async {
    return await generalRepo.getAllFoodOfRestaurant(restaurantId);
  }

  clearData() {
    _reviewedRestaurants = [];
    notifyListeners();
  }
}
