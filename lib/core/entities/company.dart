import 'dart:typed_data';

import 'package:dekor_farben_app/core/entities/recent_work.dart';

import 'campaign.dart';

class Company {
  String id;
  String companyName;
  String companyPassword;
  DateTime createdAt;
  DateTime updatedAt;
  Uint8List? image;
  List<Campaign> campaigns;
  List<RecentWork> recentWorks;

  Company(
      {required this.id,
      required this.companyName,
      required this.companyPassword,
      required this.createdAt,
      required this.updatedAt,
      required this.campaigns,
      required this.recentWorks});

  factory Company.fromApi(Map<String, dynamic> map) {
    return Company(
        id: map['id'] ?? "undefined",
        companyName: map['name'] ?? "undefined",
        companyPassword: map['companyPassword'] ?? "undefined",
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : DateTime.now(),
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : DateTime.now(),
        campaigns: Campaign.processCampaignsFromApi(map['campaigns']),
        recentWorks: RecentWork.processRecentWorksFromApi(map['recent_works'])
    );
  }

  static List<Company> fromApiList(List<dynamic> jsonList) {
    return jsonList.map((item) => Company.fromApi(item)).toList();
  }

  @override
  String toString() {
    return 'Company{id: $id, companyName: $companyName, companyPassword: $companyPassword, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
