import 'dart:typed_data';

class Invoice {
  String id;
  String companyId;
  String userId;
  String campaignId;
  DateTime createdAt;
  DateTime updatedAt;

  Uint8List? image;

  Invoice({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.campaignId,
    required this.createdAt,
    required this.updatedAt,
    this.image
  });

  factory Invoice.fromApi(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] ?? "undefined",
      companyId: map['company_id'] ?? "undefined",
      userId: map['user_id'] ?? "undefined",
      campaignId: map['campaign_id'] ?? "undefined",
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }
}
