import 'package:dekor_farben_app/infrastructure/campaign/update_campaign_request.dart';

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

class UpdateCampaignEvent extends CampaignEvent {
  final UpdateCampaignRequest request;

  UpdateCampaignEvent({required this.request});
}

class DeleteCampaignEvent extends CampaignEvent {
  final String id;

  DeleteCampaignEvent({required this.id});
}