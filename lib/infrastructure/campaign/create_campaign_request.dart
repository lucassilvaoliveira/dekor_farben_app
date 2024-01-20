class CreateCampaignRequest {
  final String name;
  final String description;
  final int reward;
  final DateTime initialDate;
  final DateTime endDate;
  final bool isOpen;
  final bool isActive;

  CreateCampaignRequest(
      {required this.name,
      required this.description,
      required this.reward,
      required this.initialDate,
      required this.endDate,
      required this.isOpen,
      required this.isActive});
}
