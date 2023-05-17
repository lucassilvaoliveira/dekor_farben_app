import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateCampaignUseCase {
  final IBaseRepository<Campaign> repository;
  final User user;

  CreateCampaignUseCase({required this.repository, required this.user});

  Future<Result<DataJsonObject, InfraException>> call({required Campaign? campaign}) async {
    if (user.userType != "admin") {
      return Error(InfraException(cause: "only admin users can create campaign!"));
    } else if (campaign == null) {
      return Error(InfraException(cause: "'campaign' cannot be null!"));
    }
    return await repository.put(entity: campaign);
  }
}
