import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/exception.dart';
import 'package:hanoi_foodtour/models/user.dart';
import 'package:hanoi_foodtour/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthRepo {
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final body = {
        "email": email,
        "password": password,
      };
      final response = await Dio().post(
        "${Utils.apiUrl}/api/login",
        data: body,
      );
      final responseData = response.data;
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
      final user = User.fromJson(currentUserMap);
      return user;
    } catch (e) {
      if (e is DioException) {
        final responseError = e.response!.data;
        if (responseError["message"] == "email-incorrect" ||
            responseError["message"] == "password-incorrect") {
          throw EmailOrPasswordIncorrectException();
        }
        throw GenericException();
      }
      throw GenericException();
    }
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final body = {
        "username": name,
        "email": email,
        "password": password,
      };
      final response = await Dio().post(
        '${Utils.apiUrl}/api/register',
        data: body,
      );
      final responseData = response.data;
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
      final user = User.fromJson(currentUserMap);
      return user;
    } catch (e) {
      if (e is DioException) {
        final responseError = e.response!.data;
        if (responseError["message"] == "email-already-in-use") {
          throw EmailAlreadyInUseAuthException();
        }
        throw GenericException();
      }
      throw GenericException();
    }
  }

  signOut() {}
}
