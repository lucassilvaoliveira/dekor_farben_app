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
      id: map['companyId'] ?? "undefined",
      companyName: map['companyName'] ?? "undefined",
      companyImagePath: map['companyImagePath'],
      companyPassword: map['companyPassword'] ?? "undefined",
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
