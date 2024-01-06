
abstract class CampaignEvent {}

class GetCompanyCampaignsEvent extends CampaignEvent {
  final String companyId;

  GetCompanyCampaignsEvent({required this.companyId});
}