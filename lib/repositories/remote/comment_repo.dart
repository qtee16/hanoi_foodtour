import 'package:dio/dio.dart';
import 'package:hanoi_foodtour/models/comment.dart';
import 'package:injectable/injectable.dart';

import '../../utils/utils.dart';

@singleton
class CommentRepo {
  Future<Comment> sendComment(String type, Map<String, dynamic> data, String objectId, String token) async {
    final response = await Dio().post(
      "${Utils.apiUrl}/api/$type/$objectId/comment",
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final responseData = response.data;
    final comment = Comment.fromJson(responseData["data"]);
    return comment;
  }

  Future<List<Comment>> getComment(String type, String objectId, int limit, {int page = 0}) async {
    final response = await Dio().get(
      "${Utils.apiUrl}/api/$type/$objectId/comment?limit=$limit&page=$page",
    ); 

    final responseData = response.data;
    final commentListMap = responseData["data"];
    List<Comment> result = [];
    commentListMap.forEach((commentMap) {
      Comment comment = Comment.fromJson(commentMap);
      result.add(comment);
    });
    return result;
  }

  // Future<Comment> commentFood(Map<String, dynamic> data, String foodId, String token) async {
  //   final response = await Dio().post(
  //     "${Utils.apiUrl}/api/food/$foodId/comment",
  //     data: data,
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ),
  //   );
  //   final responseData = response.data;
  //   final comment = Comment.fromJson(responseData["data"]);
  //   return comment;
  // }

  // Future<List<Comment>> getFoodComment(String foodId, int limit, {int page = 0}) async {
  //   final response = await Dio().get(
  //     "${Utils.apiUrl}/api/food/$foodId/comment?limit=$limit&page=$page",
  //   ); 

  //   final responseData = response.data;
  //   final commentListMap = responseData["data"];
  //   List<Comment> result = [];
  //   commentListMap.forEach((commentMap) {
  //     Comment comment = Comment.fromJson(commentMap);
  //     result.add(comment);
  //   });
  //   return result;
  // }
}