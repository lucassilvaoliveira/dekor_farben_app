import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ProductMemoryRepositoryImpl implements IBaseRepository<Product> {
  @override
  Future<Result<List<Product>, InfraException>> get() async {
    try {
      return Success(List.generate(
        5,
        (index) => Product(
          id: uuid.v4(),
          companyId: uuid.v4(),
          productPrice: 100,
          productDescription: "productDescription $index",
          productImagePath: null,
          productAmount: index,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ));
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }

  @override
  Future<Result<Product, InfraException>> getOne({required String? entityId}) async {
    if (entityId != null) {
      return Success(Product(
        id: entityId,
        companyId: uuid.v4(),
        productPrice: 500,
        productDescription: "productDescription 1",
        productImagePath: null,
        productAmount: 5,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    return Error(InfraException(cause: "'entityId' is missing"));
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Product entity}) async {
    try {
      return Success(DataJsonObject(status: 201, body: {
        "message": "Product created successfully!"
      }));
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }
}
