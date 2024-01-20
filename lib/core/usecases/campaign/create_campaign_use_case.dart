import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../infrastructure/implementations/http/campaign_http_repository_impl.dart';

class CreateCampaignUseCase {
  final IBaseRepository<Campaign> repository;

  CreateCampaignUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required Campaign campaign}) async {
    if (repository is CampaignHttpRepositoryImpl) {
      final repositoryImpl = repository as CampaignHttpRepositoryImpl;
      return await repositoryImpl.put(entity: campaign);
    } else {
      return Future.error(InfraException(cause: "Could complete operation"));
    }
  }
}
