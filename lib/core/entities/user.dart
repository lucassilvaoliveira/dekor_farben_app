class User {
  String id;
  String? userType;
  String userEmail;
  String userPassword;
  String userName;
  String telephoneNumber;
  DateTime userBirthday;
  String userCpf;
  int userPoints;
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
    required this.userCpf,
    required this.userPoints,
    required this.userAvatarPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromRestRoute(Map<String, dynamic> map) {
    return User(
      id: map['userId'] ?? "undefined",
      userType: map['userType'],
      userEmail: map['userEmail'] ?? "undefined",
      userPassword: map['userPassword'] ?? "undefined",
      userName: map['userName'] ?? "undefined",
      telephoneNumber: map['telephone_number'] ?? "undefined",
      userBirthday: map['userBirthday'] != null ? DateTime.parse(map['userBirthday']) : DateTime.now(),
      userCpf: map['userCpf'] ?? "undefined",
      userPoints: map['userPoints'] ?? 0,
      userAvatarPath: map['userAvatarPath'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}
