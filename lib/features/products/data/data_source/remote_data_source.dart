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
  await dio.delete( 'https://accessories-eshop.runasp.net/api/products/$id', ); 
  } }