import 'package:arven/features/products/data/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;

  HomeSuccess(this.products);
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}