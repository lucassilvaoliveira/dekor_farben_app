import 'dart:typed_data';

class RecentWork {
  String id;
  String companyId;
  String recentWorkName;
  String recentWorkDescription;
  DateTime recentWorkDate;
  Object? recentWorkPublication;
  String recentWorkCreatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  Uint8List? image;

  RecentWork({
    required this.id,
    required this.companyId,
    required this.recentWorkName,
    required this.recentWorkDescription,
    required this.recentWorkDate,
    required this.recentWorkPublication,
    required this.recentWorkCreatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecentWork.fromMap(Map<String, dynamic> map) {
    return RecentWork(
      id: map['id'] ?? "undefined",
      companyId: map['company_id'] ?? "undefined",
      recentWorkName: map['recentWorkName'] ?? "undefined",
      recentWorkDescription: map['recentWorkDescription'] ?? "undefined",
      recentWorkDate: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      recentWorkPublication: null,
      recentWorkCreatedBy: map['recentWorkCreatedBy'] ?? "undefined",
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : DateTime.now(),
    );
  }

  static List<RecentWork> processRecentWorksFromApi(List<dynamic> recentWorks) {
    return List<RecentWork>.from(
      recentWorks.map(
            (item) {
          if (item is Map<String, dynamic>) {
            return RecentWork.fromMap(item);
          } else {
            return null;
          }
        },
      ).where((item) => item != null),
    );
  }
}
