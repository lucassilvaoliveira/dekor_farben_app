import 'dart:io';

import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../infrastructure/implementations/http/product_http_repository_impl.dart';

class CreateProductUseCase {
  final IBaseRepository<Product> repository;

  CreateProductUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required Product product, required File file}) async {
    if (repository is ProductHttpRepositoryImpl) {
      final repositoryImpl = repository as ProductHttpRepositoryImpl;
      return await repositoryImpl.create(entity: product, image: file);
    } else {
      return Future.error(InfraException(cause: "Could not complete operation"));
    }
  }
}