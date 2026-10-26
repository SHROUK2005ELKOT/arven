import 'package:arven/features/products/data/data_source/category_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:arven/features/products/presentation/cubit/category_state.dart';
class CategoryCubit extends Cubit<CategoryState> {
   final CategoriesRemoteDataSource categoriesRemoteDataSource;
CategoryCubit(this.categoriesRemoteDataSource) : super(CategoryInitial());
Future<void> getCategories() async { emit(CategoryLoading());
try {
  final categories =
      await categoriesRemoteDataSource.getCategories();

  emit(CategorySuccess(categories));
} catch (e) {
  emit(CategoryFailure(e.toString()));
}
} }