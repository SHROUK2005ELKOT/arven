import 'package:arven/core/utils/cache_helper.dart';
import 'package:arven/features/products/data/models/product_model.dart'; 
import 'package:dio/dio.dart';
class ProductsRemoteDataSource { 
final Dio dio;
ProductsRemoteDataSource(this.dio);
Future<List<ProductModel>> getProducts() async {
 const int pageSize = 20; int page = 1;
bool hasNextPage = true;
final List<ProductModel> products = [];

while (hasNextPage) {
  final response = await dio.get(
    'https://accessories-eshop.runasp.net/api/products',
    queryParameters: {
      'page': page,
      'pageSize': pageSize,
    },
  );

  final data = response.data as Map<String, dynamic>;
 final List<dynamic> items = data['items'] ?? [];

print('PRODUCTS RESPONSE: ${response.data}');

for (final item in items) {
  print('Product: ${item['name']}');
  print('Seller ID: ${item['sellerId']}');
  print('Categories: ${item['categories']}');
  print('----------------------');
}

  products.addAll(
    items.map(
      (item) => ProductModel.fromJson(
        item as Map<String, dynamic>,
      ),
    ),
  );

  hasNextPage = data['hasNextPage'] == true;
  page++;
}

return products;
}
Future<void> deleteProduct(String id) async {
  try {
    final token = CacheHelper.getData(key: 'accessToken');

    final response = await dio.delete(
      'https://accessories-eshop.runasp.net/api/products/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print('DELETE STATUS: ${response.statusCode}');
    print('DELETE RESPONSE: ${response.data}');
  } on DioException catch (e) {
    print('DELETE STATUS: ${e.response?.statusCode}');
    print('DELETE ERROR: ${e.response?.data}');
    rethrow;
  }
}
  
Future<void> addProduct(Map<String, dynamic> productData) async {
  await dio.post(
    'https://accessories-eshop.runasp.net/api/products',
    data: productData,
    options: Options(
      headers: {
        'Authorization':
            'Bearer ${CacheHelper.getData(key: 'accessToken')}',
      },
    ),
  );
}

   }