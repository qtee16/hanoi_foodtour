import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/exception.dart';
import 'package:hanoi_foodtour/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthRepo {
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      "email": email,
      "password": password,
    };
    final response = await Dio().post(
      "${Utils.apiUrl}/api/login",
      data: data,
    );
    final responseData = response.data;

    // process response
    if (responseData["status"] == "success") {
      final token = responseData["token"];
      final data = responseData["data"];
      final userData = {
        "token": token,
        "user_id": data["_id"],
      };
      final encodeData = json.encode(userData);
      prefs.setString("user_data", encodeData);
      final currentUserMap = {
        "id": data["_id"],
        "username": data["username"],
        "email": data["email"],
        "avatarUrl": data["avatarUrl"],
      };
      return currentUserMap;
    } else if (responseData["status"] == "error") {
      if (responseData["message"] == "email-incorrect" ||
          responseData["message"] == "password-incorrect") {
        throw EmailOrPasswordIncorrectException();
      }
      throw GenericException();
    } else {
      throw GenericException();
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      "username": name,
      "email": email,
      "password": password,
    };
    final response = await Dio().post(
      '${Utils.apiUrl}/api/register',
      data: data,
    );
    final responseData = response.data;

    // process response
    if (responseData["status"] == "success") {
      final token = responseData["token"];
      final data = responseData["data"];
      final userData = {
        "token": token,
        "user_id": data["_id"],
      };
      final encodeData = json.encode(userData);
      prefs.setString("user_data", encodeData);
      final currentUserMap = {
        "id": data["_id"],
        "username": data["username"],
        "email": data["email"],
        "avatarUrl": data["avatarUrl"],
      };
      return currentUserMap;
    } else if (responseData["status"] == "error") {
      if (responseData["message"] == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      }
      throw GenericException();
    } else {
      throw GenericException();
    }
  }

  signOut() {}
}
