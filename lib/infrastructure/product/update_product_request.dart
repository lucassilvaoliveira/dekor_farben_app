class UpdateProductRequest {
  final String id;
  final String companyId;
  final String campaignId;
  final String name;
  final String description;
  final double price;

  UpdateProductRequest({
    required this.id,
    required this.companyId,
    required this.campaignId,
    required this.name,
    required this.description,
    required this.price
  });
}