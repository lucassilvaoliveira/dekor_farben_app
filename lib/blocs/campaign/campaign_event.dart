import '../../infrastructure/campaign/create_campaign_request.dart';

abstract class CampaignEvent {}

class GetCompanyCampaignsEvent extends CampaignEvent {
  final String companyId;

  GetCompanyCampaignsEvent({required this.companyId});
}

class CreateCampaignEvent extends CampaignEvent {
  final CreateCampaignRequest request;

  CreateCampaignEvent({required this.request});
}