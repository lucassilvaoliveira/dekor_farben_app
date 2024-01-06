import 'package:dekor_farben_app/core/entities/product.dart';

class Campaign {
  String id;
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
      id: map['id'] ?? "undefined",
      campaignParticipantsId: map['campaignParticipantsId'] ?? [],
      products: List<Product>.from(
        (map['products']).map<Product>(
          (e) => Product.fromMap(e),
        ),
      ),
      campaignName: map['name'] ?? "undefined",
      campaignDescription: map['description'] ?? "undefined",
      campaignReward: map['reward'] ?? 0,
      campaignInitialDate: map['initial_date'] != null
          ? DateTime.parse(map['initial_date'])
          : DateTime.now(),
      campaignEndDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'])
          : DateTime.now(),
      campaignIsOpen: map['is_open'] ?? false,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }

  static List<Campaign> processCampaignsFromApi(List<dynamic> campaignsList) {
      return List<Campaign>.from(
        campaignsList.map(
              (item) {
            if (item is Map<String, dynamic>) {
              return Campaign.fromApi(item);
            } else {
              return null;
            }
          },
        ).where((item) => item != null),
      );
  }
}
