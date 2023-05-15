class UserCampaign {
  String id;
  String userId;
  String campaignId;
  bool? isRescued;
  DateTime createdAt;
  DateTime updatedAt;
  
  UserCampaign({
    required this.id,
    required this.userId,
    required this.campaignId,
    required this.isRescued,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserCampaign.fromMap(Map<String, dynamic> map) {
    return UserCampaign(
      id: map['userCampaignId'] != null ? map['userCampaignId'] as String : "undefined",
      userId: map['userId'] != null ? map['userId'] as String : "undefined",
      campaignId: map['campaignId'] != null ? map['campaignId'] as String : "undefined",
      isRescued: map['isRescued'] != null ? map['isRescued'] as bool : true,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
