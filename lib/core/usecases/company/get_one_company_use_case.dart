import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetOneCompanyUseCase {
  final IBaseRepository<Company> repository;

  GetOneCompanyUseCase({required this.repository});

  Future<Result<Company, InfraException>> call({required String companyId}) async {
    return await repository.getOne(entityId: companyId);
  }
}
