class CampaignProduct {
  String id;
  String campaignId;
  String productId;
  DateTime createdAt;
  DateTime updatedAt;

  CampaignProduct({
    required this.id,
    required this.campaignId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampaignProduct.fromMap(Map<String, dynamic> map) {
    return CampaignProduct(
      id: map['campaignProductId'] ?? "undefined",
      campaignId: map['campaignId'] ?? "undefined",
      productId: map['productId'] ?? "undefined",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
