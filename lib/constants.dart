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
  static const greyBorder = Color(0xFFC2BEBE);
  static const yellowColor = Color(0xFFFFD864);
  static const redColor = Colors.red;
  static const greyTitle = Color(0xFF666666);
}

class AssetPaths {
  static final imagePath = ImagePath();
  static final iconPath = IconPath();
}

class ImagePath {
  final getDefaultUserImagePath = "assets/images/default_user.png";
  final getDefaultLoadingImagePath = "assets/images/default-loading-image.png";
  final getLogoImagePath = "assets/icons/logo-app.png";
}

class IconPath {
  final getRestaurantIconPath = "assets/icons/restaurant.png";
  final getFoodIconPath = "assets/icons/food.png";
  final getMapIconPath = "assets/icons/map.png";
  final getCoinIconPath = "assets/icons/coin.png";
  final getStarIconPath = "assets/icons/star.png";
  final getLocationIconPath = "assets/icons/location.png";
  final getHeartIconPath = "assets/icons/heart-filled.png";
  final getHeartOutlineIconPath = "assets/icons/heart-outline.png";
  final getRouteIconPath = "assets/icons/route.png";
  final getLikeOutlineIconPath = "assets/icons/like-outline.png";
  final getLikeFillIconPath = "assets/icons/like-fill.png";
  final getDislikeOutlineIconPath = "assets/icons/dislike-outline.png";
  final getDislikeFillIconPath = "assets/icons/dislike-fill.png";
  final getInfoIconPath = "assets/icons/toast/info_icon.svg";
  final getWarningIconPath = "assets/icons/toast/warning_icon.svg";
  final getCheckIconPath = "assets/icons/toast/checked_icon.svg";
  final getAlertIconPath = "assets/icons/toast/alert_triangle.svg";
  final getLoadingIconPath = "assets/icons/loading.png";
  final getReviewIconPath = "assets/icons/review.png";
}
