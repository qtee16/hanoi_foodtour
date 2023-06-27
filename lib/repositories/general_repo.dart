import 'package:hanoi_foodtour/models/user.dart';
import 'package:hanoi_foodtour/repositories/remote/auth_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/food_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/rating_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/restaurant_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/search_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/user_repo.dart';
import 'package:injectable/injectable.dart';

import '../models/food.dart';
import '../models/rating.dart';
import '../models/restaurant.dart';

@singleton
class GeneralRepo {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;
  final RestaurantRepo _restaurantRepo;
  final RatingRepo _ratingRepo;
  final FoodRepo _foodRepo;
  final SearchRepo _searchRepo;

  GeneralRepo(
    this._authRepo,
    this._userRepo,
    this._restaurantRepo,
    this._ratingRepo,
    this._foodRepo,
    this._searchRepo,
  );

  // -------------- Auth repo --------------
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _authRepo.signUp(name: name, email: email, password: password);
  }

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    return await _authRepo.signIn(email: email, password: password);
  }

  // ---------------------------------------

  // -------------- User repo --------------
  Future<User?> fetchCurrentUser() async {
    return await _userRepo.fetchCurrentUser();
  }
  // ---------------------------------------

  // -------------- Restaurant repo --------------
  Future<Restaurant> createRestaurant(
      Map<String, dynamic> data, String? token) async {
    return await _restaurantRepo.createRestaurant(data, token);
  }

  Future<List<Restaurant>?> getAllReviewedRestaurant(String? token) async {
    return await _restaurantRepo.getAllReviewedRestaurant(token);
  }

  Future<List<Restaurant>> getAllRestaurant() async {
    return await _restaurantRepo.getAllRestaurant();
  }

  Future<Restaurant> getRestaurantById(String restaurantId) async {
    return await _restaurantRepo.getRestaurantById(restaurantId);
  }

  Future<List<Food>> getAllFoodOfRestaurant(String restaurantId) async {
    return await _restaurantRepo.getAllFoodOfRestaurant(restaurantId);
  }
  // ---------------------------------------

  // -------------- Rating repo --------------
  Future<void> ratingRestaurant(Map<String, dynamic> data, String token) async {
    await _ratingRepo.ratingRestaurant(data, token);
  }

  Future<Rating?> getMyRestaurantRating(
    String userId,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await _ratingRepo.getMyRestaurantRating(userId, data, token);
  }

  Future<List<Rating>> getAllRestaurantRating(Map<String, dynamic> data) async {
    return await _ratingRepo.getAllRestaurantRating(data);
  }

  Future<void> ratingFood(Map<String, dynamic> data, String token) async {
    return await _ratingRepo.ratingFood(data, token);
  }

  Future<Rating?> getMyFoodRating(
    String userId,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await _ratingRepo.getMyFoodRating(userId, data, token);
  }

  Future<List<Rating>> getAllFoodRating(Map<String, dynamic> data) async {
    return await _ratingRepo.getAllFoodRating(data);
  }
  // ---------------------------------------

  // -------------- Food repo --------------
  Future<Food> createFood(Map<String, dynamic> data, String? token) async {
    return await _foodRepo.createFood(data, token);
  }

  Future<List<Food>> getAllFood() async {
    return await _foodRepo.getAllFood();
  }
  // ---------------------------------------

  // -------------- Search repo --------------
  Future<Map<String, dynamic>> searchFoodAndRestaurant(String searchText) async {
    return await _searchRepo.searchFoodAndRestaurant(searchText);
  }
  // ---------------------------------------

}
