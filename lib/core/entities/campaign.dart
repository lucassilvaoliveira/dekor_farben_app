import 'package:dekor_farben_app/core/entities/product.dart';

class Campaign {
  String id;
  String creatorId;
  List<String> campaignParticipantsId;
  List<Product> products;
  String campaignName;
  String campaignDescription;
  int campaignReward;
  DateTime campaignInitialDate;
  DateTime campaignEndDate;
  bool campaignIsOpen;
  DateTime createdAt;
  DateTime updatedAt;

  Campaign({
    required this.id,
    required this.creatorId,
    required this.campaignParticipantsId,
    required this.products,
    required this.campaignName,
    required this.campaignDescription,
    required this.campaignReward,
    required this.campaignInitialDate,
    required this.campaignEndDate,
    required this.campaignIsOpen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Campaign.fromApi(Map<String, dynamic> map) {
    return Campaign(
      id: map['campaignId'] ?? "undefined",
      creatorId: map['creatorId'] ?? "undefined",
      campaignParticipantsId: map['campaignParticipantsId'] ?? [],
      products: List<Product>.from(
        (map['products']).map<Product>(
          (e) => Product.fromMap(e),
        ),
      ),
      campaignName: map['campaignName'] ?? "undefined",
      campaignDescription: map['campaignDescription'] ?? "undefined",
      campaignReward: map['campaignReward'] ?? 0,
      campaignInitialDate: map['campaignInitialDate'] != null
          ? DateTime.parse(map['campaignInitialDate'])
          : DateTime.now(),
      campaignEndDate: map['campaignEndDate'] != null
          ? DateTime.parse(map['campaignEndDate'])
          : DateTime.now(),
      campaignIsOpen: map['campaignIsOpen'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }
}
