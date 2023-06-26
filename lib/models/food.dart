import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  final String id;
  final String userId;
  final String restaurantId;
  final String foodName;
  final int category;
  final int price;
  final String review;
  final String imageUrl;
  final List<dynamic> likedUserIdList;
  final double rating;
  final int countRatings;

  const Food({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.foodName,
    required this.category,
    required this.price,
    required this.review,
    required this.imageUrl,
    required this.likedUserIdList,
    required this.rating,
    required this.countRatings,
  });

  factory Food.fromJson(Map<String, dynamic> data) => _$FoodFromJson(data);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
