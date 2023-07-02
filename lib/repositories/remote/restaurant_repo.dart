import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';

@singleton
class RestaurantRepo {
  Future<Restaurant> createRestaurant(
    Map<String, dynamic> data,
    String? token,
  ) async {
    final response = await Dio().post(
      "${Utils.apiUrl}/api/v1/review/restaurant",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final responseData = response.data;
    final restaurant = Restaurant.fromJson(responseData["data"]);
    return restaurant;
  }

  Future<Restaurant> updateRestaurant(
    String restaurantId,
    Map<String, dynamic> data,
    String token,
  ) async {
    final response = await Dio().put(
      "${Utils.apiUrl}/api/v1/review/restaurant/$restaurantId",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final responseData = response.data;
    final restaurant = Restaurant.fromJson(responseData["data"]);
    return restaurant;
  }

  Future<Restaurant> deleteRestaurant(
    String restaurantId,
    String userId,
    String token,
  ) async {
    final response = await Dio().delete(
      "${Utils.apiUrl}/api/v1/review/restaurant/$restaurantId",
      data: { "userId": userId },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final responseData = response.data;
    final restaurant = Restaurant.fromJson(responseData["data"]);
    return restaurant;
  }

  Future<List<Restaurant>> getAllReviewedRestaurant(String userId, String token) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/v1/review/restaurant",
      data: { "userId": userId },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    List<dynamic> responseData = response.data["data"];
    final result = responseData.map((e) {
      final restaurant = Restaurant.fromJson(e);
      return restaurant;
    }).toList();
    return result;
  }

  Future<List<Restaurant>> getTopRatingRestaurants(int limit, {int page = 0}) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/v1/restaurant?limit=$limit&page=$page",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    List<dynamic> responseData = response.data["data"];
    final result = responseData.map((e) {
      final restaurant = Restaurant.fromJson(e);
      return restaurant;
    }).toList();
    return result;
  }

  Future<Restaurant> getRestaurantById(String restaurantId) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/v1/restaurant/$restaurantId",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    final responseData = response.data;
    Restaurant restaurant = Restaurant.fromJson(responseData["data"]);
    return restaurant;
  }

  Future<List<Food>> getAllFoodOfRestaurant(String restaurantId) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/v1/restaurant/$restaurantId/foods",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    List<dynamic> responseData = response.data["data"];
    final result = responseData.map((e) {
      final restaurant = Food.fromJson(e);
      return restaurant;
    }).toList();
    return result;
  }
}
