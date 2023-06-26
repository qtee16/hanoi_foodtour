import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../models/rating.dart';
import '../../utils/utils.dart';

@singleton
class RatingRepo {
  Future<void> ratingRestaurant(Map<String, dynamic> data, String token) async {
    final response = await Dio().post(
      "${Utils.apiUrl}/api/rating/restaurant",
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
  }

  Future<Rating?> getMyRestaurantRating(
    String userId,
    Map<String, dynamic> data,
    String token,
  ) async {
    print("LOG2222");
    final response = await Dio().get(
      "${Utils.apiUrl}/api/rating/restaurant/$userId",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print("LOG3333");
    final responseData = response.data;
    if (responseData["data"] != null) {
      final myRating = Rating.fromJson(responseData["data"]);
      print(responseData["data"]);
      return myRating;
    }
    return null;
  }

  Future<List<Rating>> getAllRestaurantRating(Map<String, dynamic> data) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/rating/restaurant",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    final responseData = response.data;
    List result = responseData["data"];
    final ratingList = result.map((rating) {
      print(rating);
      return Rating.fromJson(rating);
    }).toList();
    print(ratingList);

    return ratingList;
  }

  Future<void> ratingFood(Map<String, dynamic> data, String token) async {
    final response = await Dio().post(
      "${Utils.apiUrl}/api/rating/food",
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
  }

  Future<Rating?> getMyFoodRating(
    String userId,
    Map<String, dynamic> data,
    String token,
  ) async {
    print("LOG2222");
    final response = await Dio().get(
      "${Utils.apiUrl}/api/rating/food/$userId",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print("LOG3333");
    final responseData = response.data;
    print(responseData);
    if (responseData["data"] != null) {
      print(responseData["data"]);
      final myRating = Rating.fromJson(responseData["data"]);
      return myRating;
    }
    return null;
  }

  Future<List<Rating>> getAllFoodRating(Map<String, dynamic> data) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/rating/food",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    final responseData = response.data;
    List result = responseData["data"];
    final ratingList = result.map((rating) {
      print(rating);
      return Rating.fromJson(rating);
    }).toList();
    print(ratingList);

    return ratingList;
  }
}
