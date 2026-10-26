import 'package:arven/features/products/data/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}