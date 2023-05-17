import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetProductUseCase {
  final IBaseRepository<Product> repository;

  GetProductUseCase({required this.repository});

  Future<Result<List<Product>, InfraException>> call() async {
    return await repository.get();
  }
}
