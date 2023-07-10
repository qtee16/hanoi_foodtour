import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/models/food.dart';
import 'package:hanoi_foodtour/models/restaurant.dart';
import 'package:hanoi_foodtour/views/auth/sign_in_screen.dart';
import 'package:hanoi_foodtour/views/auth/sign_up_screen.dart';
import 'package:hanoi_foodtour/views/comment/comment_screen.dart';
import 'package:hanoi_foodtour/views/favorite/favorite_screen.dart';
import 'package:hanoi_foodtour/views/food/food_detail_screen.dart';
import 'package:hanoi_foodtour/views/home/home_screen.dart';
import 'package:hanoi_foodtour/views/profile/change_password_screen.dart';
import 'package:hanoi_foodtour/views/profile/profile.dart';
import 'package:hanoi_foodtour/views/profile/profile_detail.dart';
import 'package:hanoi_foodtour/views/profile/update_info_detail.dart';
import 'package:hanoi_foodtour/views/restaurant/restaurant_detail_screen.dart';
import 'package:hanoi_foodtour/views/review/review_food_screen.dart';
import 'package:hanoi_foodtour/views/review/review_overview_screen.dart';
import 'package:hanoi_foodtour/views/review/review_restaurant_screen.dart';
import 'package:hanoi_foodtour/views/search/search_screen.dart';
import 'package:hanoi_foodtour/views/splash/splash.dart';
import 'package:hanoi_foodtour/views/list_detail/list_detail_screen.dart';

import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  Map<String, dynamic>? arguments =
      settings.arguments as Map<String, dynamic>? ?? {};
  switch (settings.name) {
    case ROUTE_SPLASH:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Splash(),
      );
    case ROUTE_SIGN_IN:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SignInScreen(),
      );
    case ROUTE_SIGN_UP:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SignUpScreen(),
      );
    case ROUTE_HOME:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const HomeScreen(),
      );
    case ROUTE_PROFILE:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Profile(),
      );
    case ROUTE_PROFILE_DETAIL:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ProfileDetail(),
      );
    case ROUTE_FOOD_DETAIL:
      Food food = arguments["food"];
      List? likedData = arguments["likedData"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: FoodDetailScreen(
          food: food,
          likedData: likedData,
        ),
      );
    case ROUTE_RESTAURANT_DETAIL:
      Restaurant restaurant = arguments["restaurant"];
      List? likedData = arguments["likedData"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: RestaurantDetailScreen(
          restaurant: restaurant,
          likedData: likedData,
        ),
      );
    case ROUTE_COMMENT:
      String objectId = arguments["objectId"];
      String type = arguments["type"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CommentScreen(objectId: objectId, type: type,),
      );
    case ROUTE_REVIEW_OVERVIEW:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ReviewOverviewScreen(),
      );
    case ROUTE_REVIEW_RESTAURANT:
      Restaurant? restaurant = arguments["restaurant"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ReviewRestaurantScreen(restaurant: restaurant,),
      );
    case ROUTE_REVIEW_FOOD:
      String restaurantId = arguments["restaurantId"];
      Food? food = arguments["food"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ReviewFoodScreen(
          restaurantId: restaurantId,
          food: food,
        ),
      );
    case ROUTE_SEARCH:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SearchScreen(),
      );
    case ROUTE_LIST_DETAIL:
      String title = arguments["title"];
      String type = arguments["type"];
      bool? isFood = arguments["isFood"];
      List? data = arguments["data"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ListDetailScreen(title: title, type: type, isFood: isFood ?? true, data: data,),
      );
    case ROUTE_FAVORITE:
      String title = arguments["title"];
      String type = arguments["type"];
      bool? isFood = arguments["isFood"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: FavoriteScreen(title: title, type: type, isFood: isFood ?? true,),
      );
    case ROUTE_UPDATE_INFO_DETAIL:
      String title = arguments["title"];
      String type = arguments["type"];
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: UpdateInfoDetail(title: title, type: type)
      );
    case ROUTE_CHANGE_PASSWORD:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ChangePasswordScreen()
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute(
    {required String routeName,
    required Widget viewToShow,
    bool animation = true,
    bool scale = false}) {
  RouteSettings _settings = RouteSettings(
    name: routeName,
  );
  // animation = true;
  if (animation) {
    return PageRouteBuilder(
      settings: _settings,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => viewToShow,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (scale) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        }
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
  return MaterialPageRoute(settings: _settings, builder: (_) => viewToShow);
}
