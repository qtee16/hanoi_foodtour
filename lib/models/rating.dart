import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  final String id;
  final String userId;
  final String ratedObjectId;
  final double rating;

  const Rating({
    required this.id,
    required this.userId,
    required this.ratedObjectId,
    required this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> data) => _$RatingFromJson(data);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
