import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../infrastructure/implementations/http/campaign_http_repository_impl.dart';

class GetCampaignUseCase {
  final IBaseRepository<Campaign> repository;

  GetCampaignUseCase({required this.repository});

  Future<Result<List<Campaign>, InfraException>> call(String companyId) async {
    if (repository is CampaignHttpRepositoryImpl) {
      final repositoryImpl = repository as CampaignHttpRepositoryImpl;
      return await repositoryImpl.getAllByCompanyId(companyId: companyId);
    } else {
      return Future.error(InfraException(cause: "Could not complete operation"));
    }
  }
}
