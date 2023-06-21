import 'package:hanoi_foodtour/models/user.dart';
import 'package:hanoi_foodtour/repositories/remote/auth_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/restaurant_repo.dart';
import 'package:hanoi_foodtour/repositories/remote/user_repo.dart';
import 'package:injectable/injectable.dart';

import '../models/restaurant.dart';

@singleton
class GeneralRepo {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;
  final RestaurantRepo _restaurantRepo;

  GeneralRepo(this._authRepo, this._userRepo, this._restaurantRepo);

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

  Future<List<Restaurant>?> fetchAllReviewedRestaurant(String? token) async {
    return await _restaurantRepo.fetchAllReviewedRestaurant(token);
  }
  // ---------------------------------------
}
