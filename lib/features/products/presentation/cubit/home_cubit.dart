import 'package:arven/features/products/data/data_source/remote_data_source.dart'; 
import 'package:arven/features/products/presentation/cubit/home_state.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeCubit extends Cubit<HomeState> { 

  final ProductsRemoteDataSource productsRemoteDataSource;
HomeCubit(this.productsRemoteDataSource) : 
super(HomeInitial());
Future<void> getProducts() async {
   emit(HomeLoading());
try {
  final products = await productsRemoteDataSource.getProducts();
  emit(HomeSuccess(products));
} catch (e) {
  emit(HomeFailure(e.toString()));
}
}
Future<void> deleteProduct(String productId) async {
   final currentState = state;
if (currentState is! HomeSuccess) return;

try {
  await productsRemoteDataSource.deleteProduct(productId);

  final updatedProducts = currentState.products
      .where((product) => product.id.toString() != productId)
      .toList();

  emit(HomeSuccess(updatedProducts));
} catch (e) {
  emit(HomeFailure('Failed to delete product: $e'));
}
} }