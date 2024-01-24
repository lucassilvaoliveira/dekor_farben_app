import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';
import '../../../infrastructure/implementations/http/campaign_http_repository_impl.dart';
import '../../entities/campaign.dart';

class DeleteCampaignUseCase {
  final IBaseRepository<Campaign> repository;

  DeleteCampaignUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String id}) async {
    if (repository is CampaignHttpRepositoryImpl) {
      final repositoryImpl = repository as CampaignHttpRepositoryImpl;
      return await repositoryImpl.delete(id: id);
    } else {
      return Future.error(InfraException(cause: "Could not complete operation"));
    }
  }
}