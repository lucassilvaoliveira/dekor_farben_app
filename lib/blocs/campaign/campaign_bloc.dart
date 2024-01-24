
import 'package:dekor_farben_app/blocs/campaign/campaign_event.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_state.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/usecases/campaign/create_campaign_use_case.dart';
import 'package:dekor_farben_app/core/usecases/campaign/delete_campaign_use_case.dart';
import 'package:dekor_farben_app/core/usecases/campaign/get_campaign_use_case.dart';
import 'package:dekor_farben_app/core/usecases/campaign/update_campaign_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/campaign_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final getCampaignUseCase = GetCampaignUseCase(
      repository: CampaignHttpRepositoryImpl()
  );

  final createCampaignUseCase = CreateCampaignUseCase(
      repository: CampaignHttpRepositoryImpl()
  );

  final updateCampaignUseCase = UpdateCampaignUseCase(
      repository: CampaignHttpRepositoryImpl()
  );

  final deleteCampaignUseCase = DeleteCampaignUseCase(
      repository: CampaignHttpRepositoryImpl());

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
        emit(CampaignCreateSuccessState());
      } else {
        emit(CampaignErrorState());
      }
    });
    on<UpdateCampaignEvent>((event, emit) async {
      emit(CampaignLoadingState());

      final aCampaign = Campaign(
          id: event.request.id,
          campaignParticipantsId: [],
          products: [],
          campaignName: event.request.name,
          campaignDescription: event.request.description,
          campaignReward: event.request.reward,
          campaignInitialDate: event.request.initialDate,
          campaignEndDate: event.request.endDate,
          campaignIsOpen: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final result = await updateCampaignUseCase.call(id: event.request.id, campaign: aCampaign);

      if (result.isSuccess()) {
        emit(CampaignUpdateSuccessState());
      } else {
        emit(CampaignErrorState());
      }
    });
    on<DeleteCampaignEvent>((event, emit) async {
      emit(CampaignLoadingState());

      final result = await deleteCampaignUseCase.call(id: event.id);

      if (result.isSuccess()) {
        emit(CampaignDeleteSuccessState());
      } else {
        emit(CampaignErrorState());
      }
    });
  }

}