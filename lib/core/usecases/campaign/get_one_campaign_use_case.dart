import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetOneCampaignUseCase {
  final IBaseRepository<Campaign> repository;

  GetOneCampaignUseCase({required this.repository});

  Future<Result<Campaign, InfraException>> call({required String campaignId}) async {
    return await repository.getOne(entityId: campaignId);
  }
}
