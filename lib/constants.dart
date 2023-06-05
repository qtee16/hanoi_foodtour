import 'package:flutter/material.dart';

class AppColors {
  static const mainColor = Color(0xFF87E4EA);
  static const textFieldBackgroundColor = Color(0x70FFFAFA);
  static const whiteColor = Colors.white;
  static const hintTextColor = Color(0x80000000);
  static const blackColor = Colors.black;
  static const subTitleColor = Color(0xFF757171);
  static const backgroundColor = Color(0xFFF2FFFD);
  static const greyColor = Color(0xFFD9D9D9);
  static const greyBackground = Color(0xFFEEEEEE);
  static const greyText = Color(0xFF7D7D7D);
}

class AssetPaths {
  static final imagePath = ImagePath();
  static final iconPath = IconPath();
}

class ImagePath {
  final getDefaultUserImagePath = "assets/images/default_user.png";
  final getDefaultLoadingImagePath = "assets/images/default-loading-image.png";
}

class IconPath {
  final getRestaurantIconPath = "assets/icons/restaurant.png";
  final getFoodIconPath = "assets/icons/food.png";
  final getMapIconPath = "assets/icons/map.png";
  final getCoinIconPath = "assets/icons/coin.png";
  final getStarIconPath = "assets/icons/star.png";
  final getLocationIconPath = "assets/icons/location.png";
}
