import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';
import '../../../infrastructure/implementations/http/company_http_repository_impl.dart';

class UpdateCompanyAssetUseCase {
  final IBaseRepository repository;

  UpdateCompanyAssetUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String companyId, required XFile aFile}) async {
    if (repository is CompanyHttpRepositoryImpl) {
      final repositoryImpl = repository as CompanyHttpRepositoryImpl;
      return await repositoryImpl.updateAsset(anId: companyId, aFile: aFile);
    }

    throw InfraException(cause: "Could not load asset");
  }
}