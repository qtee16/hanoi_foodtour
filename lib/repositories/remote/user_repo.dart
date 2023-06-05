import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class UserRepo {
  Future<Map<String, dynamic>?> fetchCurrentUser() async {
    final refs = await SharedPreferences.getInstance();
    final encodeData = refs.getString("user_data");
    if (encodeData == null) {
      return null;
    } else {
      final userData = json.decode(encodeData);
      final userId = userData["user_id"];
      final response = await Dio().get("${Utils.apiUrl}/api/users/$userId");
      final responseData = response.data;
      if (responseData["status"] == "success") {
        final data = responseData["data"];
        final currentUserMap = {
          "id": data["_id"],
          "username": data["username"],
          "email": data["email"],
          "avatarUrl": data["avatarUrl"],
        };
        return currentUserMap;
      } else {
        return null;
      }
    }
  }
}
