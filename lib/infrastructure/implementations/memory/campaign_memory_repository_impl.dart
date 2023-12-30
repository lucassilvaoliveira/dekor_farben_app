import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CampaignMemoryRepositoryImpl implements IBaseRepository<Campaign> {
  @override
  Future<Result<List<Campaign>, InfraException>> get() async {
    try {
      return Success(List.generate(
        5,
        (index) => Campaign(
          id: uuid.v4(),
          creatorId: uuid.v4(),
          campaignParticipantsId: [],
          products: [],
          campaignName: "campaignName $index",
          campaignDescription: "campaignDescription $index",
          campaignReward: 0,
          campaignInitialDate: DateTime.now(),
          campaignEndDate: DateTime.now(),
          campaignIsOpen: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ));
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }

  @override
  Future<Result<Campaign, InfraException>> getOne({required String? entityId}) async {
    if (entityId != null) {
      return Success(Campaign(
        id: entityId,
        creatorId: uuid.v4(),
        campaignParticipantsId: [],
        products: [],
        campaignName: "campaignName",
        campaignDescription: "campaignDescription",
        campaignReward: 0,
        campaignInitialDate: DateTime.now(),
        campaignEndDate: DateTime.now(),
        campaignIsOpen: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    return Error(InfraException(cause: "'entityId' is missing"));
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Campaign entity}) async {
    try {
      return Success(
        DataJsonObject(status: 201, body: {
          "message": "Campaign created successfully!"
        }),
      );
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }
}
