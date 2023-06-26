// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String,
      userId: json['userId'] as String,
      restaurantName: json['restaurantName'] as String,
      address: json['address'] as String,
      locationLat: (json['locationLat'] as num).toDouble(),
      locationLong: (json['locationLong'] as num).toDouble(),
      review: json['review'] as String,
      avatarUrl: json['avatarUrl'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      likedUserIdList: json['likedUserIdList'] as List<dynamic>,
      rating: (json['rating'] as num).toDouble(),
      countRatings: json['countRatings'] as int,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'restaurantName': instance.restaurantName,
      'address': instance.address,
      'locationLat': instance.locationLat,
      'locationLong': instance.locationLong,
      'review': instance.review,
      'avatarUrl': instance.avatarUrl,
      'coverImageUrl': instance.coverImageUrl,
      'likedUserIdList': instance.likedUserIdList,
      'rating': instance.rating,
      'countRatings': instance.countRatings,
    };
