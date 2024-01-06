class User {
  String id;
  String? userType;
  String userEmail;
  String userPassword;
  String userName;
  String telephoneNumber;
  DateTime? userBirthday;
  String userDocument;
  int? userPoints;
  String? userAvatarPath;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.userType,
    required this.userEmail,
    required this.userPassword,
    required this.userName,
    required this.telephoneNumber,
    required this.userBirthday,
    required this.userDocument,
    required this.userPoints,
    required this.userAvatarPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromRestRoute(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "undefined",
      userType: map['userType'],
      userEmail: map['email'] ?? "undefined",
      userPassword: map['userPassword'] ?? "undefined",
      userName: map['name'] ?? "undefined",
      telephoneNumber: map['telephone_number'] ?? "undefined",
      userBirthday: map['birthday'] != null ? DateTime.parse(map['birthday']) : DateTime.now(),
      userDocument: map['cpf'] ?? "undefined",
      userPoints: map['points'] ?? 0,
      userAvatarPath: map['userAvatarPath'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : DateTime.now(),
    );
  }
}
