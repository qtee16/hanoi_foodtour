// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as String,
      userId: json['userId'] as String,
      restaurantId: json['restaurantId'] as String,
      foodName: json['foodName'] as String,
      category: json['category'] as int,
      price: json['price'] as int,
      review: json['review'] as String,
      imageUrl: json['imageUrl'] as String,
      likedUserIdList: json['likedUserIdList'] as List<dynamic>,
      rating: (json['rating'] as num).toDouble(),
      countRatings: json['countRatings'] as int,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'restaurantId': instance.restaurantId,
      'foodName': instance.foodName,
      'category': instance.category,
      'price': instance.price,
      'review': instance.review,
      'imageUrl': instance.imageUrl,
      'likedUserIdList': instance.likedUserIdList,
      'rating': instance.rating,
      'countRatings': instance.countRatings,
    };
