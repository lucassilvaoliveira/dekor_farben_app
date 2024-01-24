
import 'dart:io';

import '../../infrastructure/product/create_product_request.dart';
import '../../infrastructure/product/update_product_request.dart';

abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent { }

class CreateProductEvent extends ProductEvent {
  final CreateProductRequest request;
  final File file;

  CreateProductEvent({required this.request, required this.file});
}

class UpdateProductEvent extends ProductEvent {
  final UpdateProductRequest request;
  final File file;

  UpdateProductEvent(this.file, {required this.request});
}