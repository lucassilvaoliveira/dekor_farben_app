class RecentWork {
  String recentWorkId;
  String companyId;
  String recentWorkName;
  String recentWorkDescription;
  DateTime recentWorkDate;
  Object? recentWorkPublication;
  String recentWorkCreatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  RecentWork({
    required this.recentWorkId,
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
      recentWorkId: map['recentWorkId'] != null ? map['recentWorkId'] as String : "undefined",
      companyId: map['companyId'] != null ? map['companyId'] as String : "undefined",
      recentWorkName: map['recentWorkName'] != null ? map['recentWorkName'] as String : "undefined",
      recentWorkDescription: map['recentWorkDescription'] != null ? map['recentWorkDescription'] as String : "undefined",
      recentWorkDate: map['recentWorkDate'] != null ? DateTime.parse(map['recentWorkDate']) : DateTime.now(),
      recentWorkPublication: null,
      recentWorkCreatedBy: map['recentWorkCreatedBy'] != null ? map['recentWorkCreatedBy'] as String : "undefined",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
