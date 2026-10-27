import 'package:arven/core/constants/end_points.dart';
import 'package:arven/core/utils/cache_helper.dart';
import 'package:arven/features/products/data/models/category_model.dart'; 
import 'package:dio/dio.dart';
class CategoriesRemoteDataSource { 
  final Dio dio;
CategoriesRemoteDataSource(this.dio);

Future<List<CategoryModel>> getCategories() async {
  final token = CacheHelper.getData(key: 'accessToken');

  if (token == null || token.isEmpty) {
    throw Exception('Please login first. Access token not found.');
  }

  final response = await dio.get(
    '${EndPoints.baseUrl}${EndPoints.categories}',
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );print('CATEGORIES RESPONSE: ${response.data}');

  final data = response.data;
  List<dynamic> categoriesJson;

  if (data is List) {
    if (data.length == 1 &&
        data.first is Map &&
        data.first['categories'] is List) {
      categoriesJson = data.first['categories'];
    } else {
      categoriesJson = data;
    }
  } else if (data is Map && data['categories'] is List) {
    categoriesJson = data['categories'];
  } else {
    throw Exception('Unexpected categories response format');
  }

  return categoriesJson
      .map(
        (item) => CategoryModel.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
      .toList();
}
}