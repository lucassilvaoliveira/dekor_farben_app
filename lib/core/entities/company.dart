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
      id: map['id'] ?? "undefined",
      companyName: map['name'] ?? "undefined",
      companyImagePath: map['companyImagePath'] ?? "undefined",
      companyPassword: map['companyPassword'] ?? "undefined",
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : DateTime.now(),
    );
  }

  static List<Company> fromApiList(List<dynamic> jsonList) {
    return jsonList.map((item) => Company.fromApi(item)).toList();
  }

  @override
  String toString() {
    return 'Company{id: $id, companyName: $companyName, companyImagePath: $companyImagePath, companyPassword: $companyPassword, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
