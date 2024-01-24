
import 'package:dekor_farben_app/core/entities/product.dart';

abstract class ProductState {}

class ProductLoadingState extends ProductState { }

class ProductInitState extends ProductState {}

class ProductGetSuccessState extends ProductState {
  final List<Product> products;

  ProductGetSuccessState({required this.products});
}

class ProductGetLoadingState extends ProductState {}

class ProductGetErrorState extends ProductState {
  final String message;

  ProductGetErrorState({required this.message});
}

class ProductCreateSuccessState extends ProductState {}
class ProductCreateFailureState extends ProductState {}
class ProductUpdateSuccessState extends ProductState {}
class ProductUpdateFailureState extends ProductState {}