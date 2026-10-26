import 'package:arven/features/products/data/models/category_model.dart'; 
import 'package:dio/dio.dart';
class CategoriesRemoteDataSource { 
  final Dio dio;
CategoriesRemoteDataSource(this.dio);
Future<List<CategoryModel>> getCategories() async { 
  final response = await dio.get( 
  'https://accessories-eshop.runasp.net/api/categories', );
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
} }