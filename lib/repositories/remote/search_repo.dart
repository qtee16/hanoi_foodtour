import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../utils/utils.dart';

@singleton
class SearchRepo {
  Future<Map<String, dynamic>> searchFoodAndRestaurant(String searchText) async {
    final data = {
      "searchText": searchText,
    };
    final response = await Dio().post(
      "${Utils.apiUrl}/api/search",
      data: data,
    );
    final responseData = response.data;
    final result = responseData["data"];
    return result;
  }
}