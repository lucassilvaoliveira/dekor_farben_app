import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateProductUseCase {
  final IBaseRepository<Product> repository;
  final User user;

  CreateProductUseCase({required this.repository, required this.user});

  Future<Result<DataJsonObject, InfraException>> call({required Product? product}) async {
    if (user.userType != "admin") {
      return Error(InfraException(cause: "only admin users can create product!"));
    } else if (product == null) {
      return Error(InfraException(cause: "'product' cannot be null!"));
    }
    return await repository.put(entity: product);
  }
}