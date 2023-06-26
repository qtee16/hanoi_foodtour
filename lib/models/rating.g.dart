// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      id: json['id'] as String,
      userId: json['userId'] as String,
      ratedObjectId: json['ratedObjectId'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'ratedObjectId': instance.ratedObjectId,
      'rating': instance.rating,
    };
