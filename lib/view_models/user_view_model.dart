import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

import '../models/food.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  UserViewModel({required this.generalRepo});

  List<Restaurant> _likedRestaurants = [];
  List<Food> _likedFoods = [];

  List<Restaurant> get likedRestaurants => _likedRestaurants;

  List<Food> get likeFoods => _likedFoods;

  Future<User?> getUserById(String userId) async {
    return await generalRepo.getUserById(userId);
  }

  Future<User> updateUserAvatar(String userId, File avatar, String token) async {
    String avatarUrl = await generalRepo.uploadImage(avatar, userId, token);
    final data = {
      "avatarUrl": avatarUrl,
    };
    return await generalRepo.updateUser(userId, data, token);
  }

  Future<User> updateUser(String userId, Map<String, dynamic> data, String token) async {
    return await generalRepo.updateUser(userId, data, token);
  }

  Future<void> getMyLikes(String userId, String type, String token) async {
    final likesData = await generalRepo.getMyLikes(userId, type, token);
    if (type == "restaurant") {
      List<Restaurant> result = [];
      for (final like in likesData) {
        String restaurantId = like["restaurantId"];
        Restaurant restaurant = await generalRepo.getRestaurantById(restaurantId);
        result.add(restaurant);
      }
      _likedRestaurants = List.from(result);
    } else if (type == "food") {
      List<Food> result = [];
      for (final like in likesData) {
        String foodId = like["foodId"];
        Food food = await generalRepo.getFoodById(foodId);
        result.add(food);
      }
      _likedFoods = List.from(result);
    }

    notifyListeners();
  }

  Future<void> likedRestaurant(String restaurantId) async {
    Restaurant restaurant = await generalRepo.getRestaurantById(restaurantId);
    _likedRestaurants.insert(0, restaurant);
    notifyListeners();
  }

  void unlikedRestaurant(String restaurantId) {
    _likedRestaurants.removeWhere((element) => element.id == restaurantId);
    notifyListeners();
  }

  Future<void> likedFood(String foodId) async {
    Food food = await generalRepo.getFoodById(foodId);
    _likedFoods.insert(0, food);
    notifyListeners();
  }

  void unlikedFood(String foodId) {
    _likedFoods.removeWhere((element) => element.id == foodId);
    notifyListeners();
  }
}