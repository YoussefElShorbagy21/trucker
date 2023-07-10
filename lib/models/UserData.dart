class AllUserData {
  List<UserData> allUser;

  AllUserData({required this.allUser});

  factory AllUserData.fromJson(Map<String, dynamic> json) => AllUserData(
        allUser:
            List<UserData>.from(json["users"].map((e) => UserData.fromJson(e))),
      );
}

class OneUserData {
  UserData userData;

  OneUserData({
    required this.userData,
  });

  factory OneUserData.fromJson(Map<String, dynamic> json) => OneUserData(
        userData: UserData.fromJson(json["user"]),
      );
}

class UserData {
  String name;
  String email;
  String phone;
  bool verified;
  String avatar;

  String role;
  String id;
  dynamic nationalId;
  List<dynamic> favoriteList;
  List<dynamic> doneTransactions;
  List<dynamic> currentTransactions;
  List<dynamic> acceptedTransactions;
  List<dynamic> reviews;

  UserData(
      {required this.name,
      required this.email,
      required this.phone,
      required this.verified,
      required this.avatar,
      required this.role,
      required this.nationalId,
      required this.favoriteList,
      required this.doneTransactions,
      required this.currentTransactions,
      required this.acceptedTransactions,
      required this.reviews,
      required this.id});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        verified: json['verified'],
        role: json['role'],
        avatar: json['avatar'] ?? '',
        nationalId: json["nationalId"] ?? '',
        favoriteList: List<String>.from(json["favoriteList"].map((x) => x)),
        doneTransactions:
            List<String>.from(json["doneTransactions"].map((x) => x)),
        currentTransactions:
            List<String>.from(json["currentTransactions"].map((x) => x)),
        acceptedTransactions:
            List<String>.from(json["acceptedTransactions"].map((x) => x)),
        reviews: List<String>.from(json["reviews"].map((x) => x)),
        id: json['_id'],
      );
}
