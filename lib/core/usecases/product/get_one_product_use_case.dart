import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetOneProductUseCase {
  final IBaseRepository<Product> repository;

  GetOneProductUseCase({required this.repository});

  Future<Result<Product, InfraException>> call({required String productId}) async {
    return await repository.getOne(entityId: productId);
  }
}
