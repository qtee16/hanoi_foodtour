
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../utils/utils.dart';

@singleton
class UploadRepo {
  Future<String> uploadImage(File file, String userId, String token) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":await MultipartFile.fromFile(file.path, filename:fileName),
    });
    final response = await Dio().post(
      "${Utils.apiUrl}/api/v1/upload/$userId",
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final responseData = response.data;
    return responseData["data"]["imageUrl"];
  }
}