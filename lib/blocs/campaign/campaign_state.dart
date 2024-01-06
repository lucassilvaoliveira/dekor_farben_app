
import '../../core/entities/campaign.dart';

abstract class CampaignState {}

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