import 'package:flutter/material.dart';
import 'package:hanoi_foodtour/views/auth/sign_in.dart';
import 'package:hanoi_foodtour/views/auth/sign_up.dart';
import 'package:hanoi_foodtour/views/food/food_detail.dart';
import 'package:hanoi_foodtour/views/home/home.dart';
import 'package:hanoi_foodtour/views/profile/profile.dart';
import 'package:hanoi_foodtour/views/profile/profile_detail.dart';
import 'package:hanoi_foodtour/views/restaurant/restaurant_detail.dart';
import 'package:hanoi_foodtour/views/splash/splash.dart';

import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  Map<String, dynamic>? arguments =
      settings.arguments as Map<String, dynamic>? ?? {};
  switch (settings.name) {
    case ROUTER_SPLASH:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Splash(),
      );
    case ROUTER_SIGN_IN:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SignIn(),
      );
    case ROUTER_SIGN_UP:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SignUp(),
      );
    case ROUTER_HOME:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Home(),
      );
    case ROUTER_PROFILE:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Profile(),
      );
    case ROUTER_PROFILE_DETAIL:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ProfileDetail(),
      );
    case ROUTER_FOOD_DETAIL:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const FoodDetail(),
      );
    case ROUTER_RESTAURANT_DETAIL:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const RestaurantDetail(),
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
