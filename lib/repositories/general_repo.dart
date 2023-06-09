import 'dart:io';

import 'package:hanoi_foodtour/models/user.dart';
import 'package:hanoi_foodtour/repositories/remote/auth_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/comment_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/food_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/like_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/rating_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/restaurant_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/search_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/upload_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/user_repo.dart';
import 'package:injectable/injectable.dart';

import '../models/comment.dart';
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
  final CommentRepo _commentRepo;
  final LikeRepo _likeRepo;
  final UploadRepo _uploadRepo;

  GeneralRepo(
    this._authRepo,
    this._userRepo,
    this._restaurantRepo,
    this._ratingRepo,
    this._foodRepo,
    this._searchRepo,
    this._commentRepo,
    this._likeRepo,
    this._uploadRepo,
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

  Future<User?> getUserById(String userId) async {
    return await _userRepo.getUserById(userId);
  }

  Future<User> updateUser(String userId, Map<String, dynamic> data, String token) async {
    return _userRepo.updateUser(userId, data, token);
  }

  Future<void> changePassword(String userId, Map<String, dynamic> data, String token) async {
    await _userRepo.changePassword(userId, data, token);
  }
  // ---------------------------------------

  // -------------- Restaurant repo --------------
  Future<Restaurant> createRestaurant(
      Map<String, dynamic> data, String? token) async {
    return await _restaurantRepo.createRestaurant(data, token);
  }

  Future<Restaurant> updateRestaurant(
    String restaurantId,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await _restaurantRepo.updateRestaurant(restaurantId, data, token);
  }

  Future<Restaurant> deleteRestaurant(
    String restaurantId,
    String userId,
    String token,
  ) async {
    return await _restaurantRepo.deleteRestaurant(restaurantId, userId, token);
  }

  Future<List<Restaurant>> getAllReviewedRestaurant(String userId, String token) async {
    return await _restaurantRepo.getAllReviewedRestaurant(userId, token);
  }

  Future<List<Restaurant>> getTopRatingRestaurants(int limit, {int page = 0}) async {
    return await _restaurantRepo.getTopRatingRestaurants(limit, page: page);
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

  Future<Food> getFoodById(String foodId) async {
    return await _foodRepo.getFoodById(foodId);
  }

  Future<List<Food>> getTopRatingFoods(int limit, {int page = 0}) async {
    return await _foodRepo.getTopRatingFoods(limit, page: page);
  }

  Future<List<Food>> getAllReviewedFood(String userId, String token) async {
    return await _foodRepo.getAllReviewedFood(userId, token);
  }

  Future<Food> updateFood(
    String foodId,
    Map<String, dynamic> data,
    String token,
  ) async {
    return await _foodRepo.updateFood(foodId, data, token);
  }

  Future<Food> deleteFood(
    String foodId,
    String userId,
    String token,
  ) async {
    return await _foodRepo.deleteFood(foodId, userId, token); 
  }
  // ---------------------------------------

  // -------------- Search repo --------------
  Future<Map<String, dynamic>> searchFoodAndRestaurant(String searchText) async {
    return await _searchRepo.searchFoodAndRestaurant(searchText);
  }
  // ---------------------------------------

  // -------------- Comment repo --------------
  Future<Comment> sendComment(String type, Map<String, dynamic> data, String restaurantId, String token) async {
    return await _commentRepo.sendComment(type, data, restaurantId, token);
  }

  Future<List<Comment>> getComment(String type, String restaurantId, int limit, {int page = 0}) async {
    return await _commentRepo.getComment(type, restaurantId, limit, page: page);
  }
  // ---------------------------------------

  // -------------- Like repo --------------
  Future<Map<String, dynamic>> sendLike(String userId, String objectId, String type, String token) async {
    return await _likeRepo.sendLike(userId, objectId, type, token);
  }

  Future<List> getAllLike(String objectId, String type) async {
    return await _likeRepo.getAllLike(objectId, type);
  }

  Future<List> getMyLikes(String userId, String type, String token) async {
    return await _likeRepo.getMyLikes(userId, type, token);
  }
  // ---------------------------------------

  // -------------- Upload repo --------------
  Future<String> uploadImage(File file, String userId, String token) async {
    return await _uploadRepo.uploadImage(file, userId, token);
  }
  // ---------------------------------------

}
