import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/models/user.dart';
import 'package:hanoi_foodtour/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class UserRepo {
  Future<User?> fetchCurrentUser() async {
    final refs = await SharedPreferences.getInstance();
    final encodeData = refs.getString("user_data");
    if (encodeData == null) {
      return null;
    } else {
      final userData = json.decode(encodeData);
      final userId = userData["user_id"];
      final token = userData["token"];
      final response = await Dio().get(
        "${Utils.apiUrl}/api/v1/users/currentUser/$userId", 
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final responseData = response.data;
      if (responseData["success"] == true) {
        final data = responseData["data"];
        final currentUserMap = {
          "id": data["_id"],
          "username": data["username"],
          "email": data["email"],
          "avatarUrl": data["avatarUrl"],
        };
        final user = User.fromJson(currentUserMap);
        return user;
      } else {
        return null;
      }
    }
  }

  Future<User?> getUserById(String userId) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/v1/users/$userId",
    );
    final responseData = response.data;
    if (responseData["success"] == true) {
      final data = responseData["data"];
      final userMap = {
        "id": data["_id"],
        "username": data["username"],
        "email": data["email"],
        "avatarUrl": data["avatarUrl"],
      };
      final user = User.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  Future<User> updateUser(String userId, Map<String, dynamic> data, String token) async {
    final response = await Dio().put(
      "${Utils.apiUrl}/api/v1/users/$userId",
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
    final restaurant = User.fromJson(responseData["data"]);
    return restaurant;
  }
}
