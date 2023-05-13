class CampaignProduct {
  String campaignProductId;
  String campaignId;
  String productId;
  DateTime createdAt;
  DateTime updatedAt;

  CampaignProduct({
    required this.campaignProductId,
    required this.campaignId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampaignProduct.fromMap(Map<String, dynamic> map) {
    return CampaignProduct(
      campaignProductId: map['campaignProductId'] != null ? map['campaignProductId'] as String : "undefined",
      campaignId: map['campaignId'] != null ? map['campaignId'] as String : "undefined",
      productId: map['productId'] != null ? map['productId'] as String : "undefined",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
