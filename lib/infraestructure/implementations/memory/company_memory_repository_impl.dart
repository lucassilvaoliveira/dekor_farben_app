import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CompanyMemoryRepositoryImpl implements IBaseRepository<Company> {
  @override
  Future<Result<List<Company>, InfraException>> get() async {
    try {
      return Success(
        List.generate(
          5,
          (index) => Company(
            id: "${uuid.v4()} index: $index}",
            companyName: "company $index",
            companyImagePath: null,
            companyPassword: "${uuid.v4()} index: $index}",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }

  @override
  Future<Result<Company, InfraException>> getOne({required String? entityId}) async {
    if (entityId != null) {
      return Success(Company(
        id: entityId,
        companyName: "luxas company",
        companyImagePath: null,
        companyPassword: uuid.v4(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    return Error(InfraException(cause: "'entityId' is missing!"));
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Company entity}) {
    throw UnimplementedError();
  }
}
