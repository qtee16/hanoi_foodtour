import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:injectable/injectable.dart';

import '../../utils/utils.dart';

@singleton
class FoodRepo {
  Future<Food> createFood(Map<String, dynamic> data, String? token) async {
    final response = await Dio().post(
      "${Utils.apiUrl}/api/review/food",
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
    final food = Food.fromJson(responseData["data"]);
    return food;
  }

  Future<List<Food>> getTopRatingFoods(int limit, {int page = 0}) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/food?limit=$limit&page=$page",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    List<dynamic> responseData = response.data["data"];
    final result = responseData.map((e) {
      final food = Food.fromJson(e);
      return food;
    }).toList();
    return result;
  }
}
