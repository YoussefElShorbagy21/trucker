class UserData{
  String name;
  String email;
  String phone;
  bool verified;
  String avatar ;
  String role;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.verified,
    required this.avatar,
    required this.role
  });

  factory UserData.fromJson(Map<String,dynamic> json) =>
      UserData(
        name: json['user']['name'],
        email: json['user']['email'],
        phone:json['user']['phone'] ,
        verified: json['user']['verified'],
          role: json['user']['role'],
        avatar: json['user']['avatar'] ?? ''
      );
}