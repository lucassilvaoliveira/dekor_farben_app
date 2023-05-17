import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCompanyUseCase {
  final IBaseRepository<Company> repository;

  GetCompanyUseCase({required this.repository});

  Future<Result<List<Company>, InfraException>> call() async {
    return await repository.get();
  }
}
