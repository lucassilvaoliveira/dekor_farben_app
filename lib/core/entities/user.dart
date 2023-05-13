class User {
  String userId;
  String userEmail;
  String userPassword;
  String userName;
  DateTime userBirthday;
  int userCpf;
  int userPoints;
  String? userAvatarPath;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.userName,
    required this.userBirthday,
    required this.userCpf,
    required this.userPoints,
    required this.userAvatarPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] != null ? map['userId'] as String : "undefined",
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : "undefined",
      userPassword: map['userPassword'] != null ? map['userPassword'] as String : "undefined",
      userName: map['userName'] != null ? map['userName'] as String : "undefined",
      userBirthday: map['userBirthday'] != null ? DateTime.parse(map['userBirthday']) : DateTime.now(),
      userCpf: map['userCpf'] != null ? map['userCpf'] as int : 0,
      userPoints: map['userPoints'] != null ? map['userPoints'] as int : 0,
      userAvatarPath: map['userAvatarPath'] != null ? map['userAvatarPath'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }
}