// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      commentedObjectId: json['commentedObjectId'] as String,
      content: json['content'] as String,
      likedUserIdList: json['likedUserIdList'] as List<dynamic>,
      dislikedUserIdList: json['dislikedUserIdList'] as List<dynamic>,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'commentedObjectId': instance.commentedObjectId,
      'content': instance.content,
      'likedUserIdList': instance.likedUserIdList,
      'dislikedUserIdList': instance.dislikedUserIdList,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
