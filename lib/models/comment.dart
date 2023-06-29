import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String id;
  final String userId;
  final String commentedObjectId;
  final String content;
  final List likedUserIdList;
  final List dislikedUserIdList;
  final String createdAt;
  final String updatedAt;

  const Comment({
    required this.id,
    required this.userId,
    required this.commentedObjectId,
    required this.content,
    required this.likedUserIdList,
    required this.dislikedUserIdList,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> data) => _$CommentFromJson(data);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}