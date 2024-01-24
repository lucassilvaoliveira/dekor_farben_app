import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';
import '../../../infrastructure/implementations/http/campaign_http_repository_impl.dart';
import '../../entities/campaign.dart';

class UpdateCampaignUseCase {
  final IBaseRepository<Campaign> repository;

  UpdateCampaignUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String id, required Campaign campaign}) async {
    if (repository is CampaignHttpRepositoryImpl) {
      final repositoryImpl = repository as CampaignHttpRepositoryImpl;
      return await repositoryImpl.update(id: id, entity: campaign);
    } else {
      return Future.error(InfraException(cause: "Could complete operation"));
    }
  }
}