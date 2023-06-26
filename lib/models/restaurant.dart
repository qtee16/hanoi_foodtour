import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String id;
  final String userId;
  final String restaurantName;
  final String address;
  final double locationLat;
  final double locationLong;
  final String review;
  final String avatarUrl;
  final String coverImageUrl;
  final List<dynamic> likedUserIdList;
  final double rating;
  final int countRatings;

  const Restaurant({
    required this.id,
    required this.userId,
    required this.restaurantName,
    required this.address,
    required this.locationLat,
    required this.locationLong,
    required this.review,
    required this.avatarUrl,
    required this.coverImageUrl,
    required this.likedUserIdList,
    required this.rating,
    required this.countRatings,
  });

  factory Restaurant.fromJson(Map<String, dynamic> data) =>
      _$RestaurantFromJson(data);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
