class Campaign {
  String campaignId;
  String campaignName;
  String campaignDescription;
  bool campaignReward;
  DateTime campaignInitialDate;
  DateTime campaignEndDate;
  bool campaignIsOpen;
  DateTime createdAt;
  DateTime updatedAt;

  Campaign({
    required this.campaignId,
    required this.campaignName,
    required this.campaignDescription,
    required this.campaignReward,
    required this.campaignInitialDate,
    required this.campaignEndDate,
    required this.campaignIsOpen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      campaignId: map['campaignId'] != null ? map['campaignId'] as String : "undefined",
      campaignName: map['campaignName'] != null ? map['campaignName'] as String : "undefined",
      campaignDescription: map['campaignDescription'] != null ? map['campaignDescription'] as String : "undefined",
      campaignReward: map['campaignReward'] != null ? map['campaignReward'] as bool : false,
      campaignInitialDate: map['campaignInitialDate'] != null ? DateTime.parse(map['campaignInitialDate']) : DateTime.now(), 
      campaignEndDate: map['campaignEndDate'] != null ? DateTime.parse(map['campaignEndDate']) : DateTime.now(),
      campaignIsOpen: map['campaignIsOpen'] != null ? map['campaignIsOpen'] as bool : false,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
