import 'dart:io';

import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/product_http_repository_impl.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';

class UpdateProductUseCase {
  final IBaseRepository<Product> repository;

  UpdateProductUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String id, required Product product, required File file}) async {
    if (repository is ProductHttpRepositoryImpl) {
      final repositoryImpl = repository as ProductHttpRepositoryImpl;
      return await repositoryImpl.update(id: id, entity: product, image: file);
    } else {
      return Future.error(InfraException(cause: "Could complete operation"));
    }
  }
}