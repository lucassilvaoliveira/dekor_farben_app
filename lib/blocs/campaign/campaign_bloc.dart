
import 'package:dekor_farben_app/blocs/campaign/campaign_event.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_state.dart';
import 'package:dekor_farben_app/core/usecases/campaign/get_campaign_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/campaign_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final getCampaignUseCase = GetCampaignUseCase(
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
  }

}