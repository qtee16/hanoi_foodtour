import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../utils/utils.dart';

@singleton
class LikeRepo {
  Future<Map<String, dynamic>> sendLike(String userId, String objectId, String type, String token) async {
    final data = {
      "userId": userId,
      (type == "restaurant" ? "restaurantId" : "foodId"): objectId,
    };
    final response = await Dio().post(
      "${Utils.apiUrl}/api/like/$type",
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
    return responseData;
  }

  Future<List> getAllLike(String objectId, String type) async {
    final response = await Dio().get("${Utils.apiUrl}/api/like/$type/$objectId");
    final responseData = response.data;
    return responseData["data"];
  }

  Future<List> getMyLikes(String userId, String type, String token) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/like/user/$userId/$type",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final responseData = response.data;
    return responseData["data"];
  }
}