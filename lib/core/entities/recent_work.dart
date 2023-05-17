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
      id: map['recentWorkId'] ?? "undefined",
      companyId: map['companyId'] ?? "undefined",
      recentWorkName: map['recentWorkName'] ?? "undefined",
      recentWorkDescription: map['recentWorkDescription'] ?? "undefined",
      recentWorkDate: map['recentWorkDate'] != null ? DateTime.parse(map['recentWorkDate']) : DateTime.now(),
      recentWorkPublication: null,
      recentWorkCreatedBy: map['recentWorkCreatedBy'] ?? "undefined",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
