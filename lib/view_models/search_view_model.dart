import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/repositories/general_repo.dart';

class SearchViewModel extends ChangeNotifier {
  final GeneralRepo generalRepo;

  SearchViewModel({required this.generalRepo});

  List<Restaurant> restaurants = [];
  List<Food> foods = [];

  List searchResult = [];

  Future<void> searchFoodAndRestaurant(String searchText) async {
    final result = await generalRepo.searchFoodAndRestaurant(searchText);

    print(result["restaurants"]);

    List<Food> tempFoods = [];
    result["foods"].forEach((foodMap) {
      final food = Food.fromJson(foodMap);
      tempFoods.add(food);
    });

    List<Restaurant> tempRestaurants = [];
    result["restaurants"].forEach((restaurantMap) {
      final restaurant = Restaurant.fromJson(restaurantMap);
      tempRestaurants.add(restaurant);
    });

    foods = List.from(tempFoods);
    restaurants = List.from(tempRestaurants);

    searchResult = [] + tempFoods + tempRestaurants;

    print(searchResult);

    notifyListeners();
  }
}