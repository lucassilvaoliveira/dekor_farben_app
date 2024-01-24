class UpdateCampaignRequest {
  final String id;
  final String name;
  final String description;
  final int reward;
  final DateTime initialDate;
  final DateTime endDate;

  UpdateCampaignRequest({
    required this.id,
    required this.name,
    required this.description,
    required this.reward,
    required this.initialDate,
    required this.endDate
  });
}