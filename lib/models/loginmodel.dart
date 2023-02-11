class LoginModel {
  late String status ;
  late String message;
  late String token  ;
  late String id ;

    LoginModel.fromJson(Map<String,dynamic> json) {
      status = json['status'];
      message = json['message'];
      token = json['token'] ?? '';
      id = json['id'] ?? '';
    }
}