class Company {
  String id;
  String companyName;
  String? companyImagePath;
  String companyPassword;
  DateTime createdAt;
  DateTime updatedAt;
  
  Company({
    required this.id,
    required this.companyName,
    required this.companyImagePath,
    required this.companyPassword,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['companyId'] != null ? map['companyId'] as String : "undefined",
      companyName: map['companyName'] != null ? map['companyName'] as String : "undefined",
      companyImagePath: map['companyImagePath'] != null ? map['companyImagePath'] as String : null,
      companyPassword: map['companyPassword'] != null ? map['companyPassword'] as String : "undefined",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
