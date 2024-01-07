import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/company_http_repository_impl.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/infra_exception.dart';

class GetCompanyAssetUseCase {
  final IBaseRepository repository;

  GetCompanyAssetUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String companyId}) async {
    if (repository is CompanyHttpRepositoryImpl) {
      final repositoryImpl = repository as CompanyHttpRepositoryImpl;
      return await repositoryImpl.getAsset(anId: companyId);
    }

    throw InfraException(cause: "Could not load asset");
  }
}