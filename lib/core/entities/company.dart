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

  factory Company.fromApi(Map<String, dynamic> map) {
    return Company(
      id: map['items']['companyId'] ?? "undefined",
      companyName: map['items']['companyName'] ?? "undefined",
      companyImagePath: map['items']['companyImagePath'],
      companyPassword: map['items']['companyPassword'] ?? "undefined",
      createdAt: map['items']['createdAt'] != null ? DateTime.parse(map['items']['createdAt']) : DateTime.now(),
      updatedAt: map['items']['updatedAt'] != null ? DateTime.parse(map['items']['updatedAt']) : DateTime.now(),
    );
  }
}
