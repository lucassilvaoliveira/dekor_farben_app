
import 'package:dekor_farben_app/blocs/campaign/campaign_event.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_state.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/usecases/campaign/create_campaign_use_case.dart';
import 'package:dekor_farben_app/core/usecases/campaign/get_campaign_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/campaign_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final getCampaignUseCase = GetCampaignUseCase(
      repository: CampaignHttpRepositoryImpl()
  );

  final createCampaignUseCase = CreateCampaignUseCase(
      repository: CampaignHttpRepositoryImpl()
  );

  CampaignBloc() : super(CampaignInitState()) {
    on<GetCompanyCampaignsEvent>((event, emit) async {
      emit(CampaignGetLoadingState());

      final result = await getCampaignUseCase.call(event.companyId);

      if (result.isSuccess()) {
        emit(CampaignGetSuccessState(campaigns: result.tryGetSuccess()!));
      } else {
        emit(CampaignGetErrorState(message: result.tryGetError()!.cause));
      }
    });
    on<CreateCampaignEvent>((event, emit) async {
      emit(CampaignLoadingState());

      final aName = event.request.name;
      final aDescription = event.request.description;
      final aReward = event.request.reward;
      final anInitialDate = event.request.initialDate;
      final anEndDate = event.request.endDate;
      final isOpen = event.request.isOpen;

      final aCampaign = Campaign(
          id: "",
          campaignParticipantsId: [],
          products: [],
          campaignName: aName,
          campaignDescription: aDescription,
          campaignReward: aReward,
          campaignInitialDate: anInitialDate,
          campaignEndDate: anEndDate,
          campaignIsOpen: isOpen,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final result = await createCampaignUseCase.call(campaign: aCampaign);

      if (result.isSuccess()) {

      } else {

      }
    });
  }

}