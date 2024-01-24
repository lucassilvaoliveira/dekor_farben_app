
import '../../core/entities/campaign.dart';

abstract class CampaignState {}

class CampaignLoadingState extends CampaignState { }

class CampaignInitState extends CampaignState {}

class CampaignGetSuccessState extends CampaignState {
  final List<Campaign> campaigns;

  CampaignGetSuccessState({required this.campaigns});
}

class CampaignGetLoadingState extends CampaignState {}

class CampaignGetErrorState extends CampaignState {
  final String message;

  CampaignGetErrorState({required this.message});
}

class CampaignCreateSuccessState extends CampaignState {}

class CampaignCreateFailureState extends CampaignState {}

class CampaignUpdateSuccessState extends CampaignState {}

class CampaignUpdateFailureState extends CampaignState {}

class CampaignDeleteSuccessState extends CampaignState {}

class CampaignDeleteFailureState extends CampaignState {}

class CampaignErrorState extends CampaignState {}