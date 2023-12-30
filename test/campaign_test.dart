import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/core/usecases/campaign/create_campaign_use_case.dart';
import 'package:dekor_farben_app/core/usecases/campaign/get_campaign_use_case.dart';
import 'package:dekor_farben_app/core/usecases/campaign/get_one_campaign_use_case.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/implementations/memory/campaign_memory_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should be create campaign", () async {
    final User adminUser = User(
      id: uuid.v4(),
      userType: "admin",
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "luxas silva",
      telephoneNumber: "47996876877",
      userBirthday: DateTime.now(),
      userCpf: 13665879957,
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final CreateCampaignUseCase createCampaignUseCase = CreateCampaignUseCase(
      repository: CampaignMemoryRepositoryImpl(),
      user: adminUser,
    );

    var sut;

    final call = await createCampaignUseCase.call(
        campaign: Campaign(
      id: uuid.v4(),
      creatorId: adminUser.id,
      campaignParticipantsId: [],
      products: [],
      campaignName: "setembro amarelo",
      campaignDescription: "baskldaskldsa",
      campaignReward: 0,
      campaignInitialDate: DateTime.now(),
      campaignEndDate: DateTime.now(),
      campaignIsOpen: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is DataJsonObject, true);
  });

  test("should be not create campaign because user is not admin", () async {
    final User user = User(
      id: uuid.v4(),
      userType: "user",
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "luxas silva",
      telephoneNumber: "47996876877",
      userBirthday: DateTime.now(),
      userCpf: 13665879957,
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final CreateCampaignUseCase createCampaignUseCase = CreateCampaignUseCase(
      repository: CampaignMemoryRepositoryImpl(),
      user: user,
    );

    var sut;

    final call = await createCampaignUseCase.call(
        campaign: Campaign(
      id: uuid.v4(),
      creatorId: user.id,
      campaignParticipantsId: [],
      products: [],
      campaignName: "setembro amarelo",
      campaignDescription: "baskldaskldsa",
      campaignReward: 0,
      campaignInitialDate: DateTime.now(),
      campaignEndDate: DateTime.now(),
      campaignIsOpen: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut, isA<InfraException>());
    expect(sut.cause, "only admin users can create campaign!");
  });

  test("should be not create campaign because campaign is null", () async {
    final User user = User(
      id: uuid.v4(),
      userType: "admin",
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "luxas silva",
      telephoneNumber: "47996876877",
      userBirthday: DateTime.now(),
      userCpf: 13665879957,
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final CreateCampaignUseCase createCampaignUseCase = CreateCampaignUseCase(
      repository: CampaignMemoryRepositoryImpl(),
      user: user,
    );

    var sut;

    final call = await createCampaignUseCase.call(campaign: null);

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut, isA<InfraException>());
    expect(sut.cause, "'campaign' cannot be null!");
  });

  test("should be return a list of campaigns", () async {
    final GetCampaignUseCase getCampaignUseCase =
        GetCampaignUseCase(repository: CampaignMemoryRepositoryImpl());

    var sut;

    final call = await getCampaignUseCase.call();

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is List<Campaign>, true);
  });

  test("should be return an specific campaign", () async {
    final GetOneCampaignUseCase getOneCampaignUseCase =
        GetOneCampaignUseCase(repository: CampaignMemoryRepositoryImpl());
    final Campaign campaignToFind = Campaign(
      id: uuid.v4(),
      creatorId: uuid.v4(),
      campaignParticipantsId: [],
      products: [],
      campaignName: "setembro amarelo",
      campaignDescription: "campaignDescription",
      campaignReward: 0,
      campaignInitialDate: DateTime.now(),
      campaignEndDate: DateTime.now(),
      campaignIsOpen: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    var sut;

    final call =
        await getOneCampaignUseCase.call(campaignId: campaignToFind.id);

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut.id, campaignToFind.id);
  });
}
