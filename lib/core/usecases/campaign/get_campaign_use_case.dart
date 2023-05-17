import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetCampaignUseCase {
  final IBaseRepository<Campaign> repository;

  GetCampaignUseCase({required this.repository});

  Future<Result<List<Campaign>, InfraException>> call() async {
    return await repository.get();
  }
}
