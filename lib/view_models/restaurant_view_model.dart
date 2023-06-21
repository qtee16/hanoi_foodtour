import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

import '../models/restaurant.dart';

class RestaurantViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  RestaurantViewModel({required this.generalRepo});

  List<Restaurant> _reviewedRestaurants = [];

  List<Restaurant> get reviewedRestaurants => _reviewedRestaurants;

  Future<void> createRestaurant(
    Map<String, dynamic> data,
    String? token,
  ) async {
    final restaurant = await generalRepo.createRestaurant(data, token);
    _reviewedRestaurants.insert(0, restaurant);
    notifyListeners();
  }

  Future<void> fetchAllReviewedRestaurant(String? token) async {
    final result = await generalRepo.fetchAllReviewedRestaurant(token);
    if (result != null) {
      _reviewedRestaurants = List.from(result);
      notifyListeners();
    }
  }
}
