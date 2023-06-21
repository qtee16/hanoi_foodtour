import 'dart:convert';

import 'package:dio/dio.dart';
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
      "${Utils.apiUrl}/api/review/restaurant",
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
    print(responseData);
    final restaurant = Restaurant.fromJson(responseData["data"]);
    return restaurant;
  }

  Future<List<Restaurant>?> fetchAllReviewedRestaurant(String? token) async {
    final refs = await SharedPreferences.getInstance();
    final encodeData = refs.getString("user_data");
    if (encodeData == null) {
      return null;
    } else {
      final userData = json.decode(encodeData);
      final userId = userData["user_id"];
      final body = {
        "userId": userId,
      };
      final response = await Dio().get(
        "${Utils.apiUrl}/api/review/reviewed-restaurant",
        data: body,
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
      print(result);
      return result;
      // final responseData = response.data;
      // if (responseData["success"] == true) {
      //   final data = responseData["data"];
      //   final currentUserMap = {
      //     "id": data["_id"],
      //     "username": data["username"],
      //     "email": data["email"],
      //     "avatarUrl": data["avatarUrl"],
      //   };
      //   final user = User.fromJson(currentUserMap);
      //   return user;
      // } else {
      //   return null;
      // }
    }
  }
}
