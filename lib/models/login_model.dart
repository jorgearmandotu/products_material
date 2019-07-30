import 'dart:convert';

List<LoginModel> loginFromJson(String str) => new List<LoginModel>.from(json.decode(str).map((x)=>LoginModel.fromJson(x)));

LoginModel loginUniqueFromJson(String str) => new LoginModel.fromJson(json.decode(str));

String loginToJson(List<LoginModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel{
  String name;
  String email;
  String pk;
  String jwt;
  bool status;
  
  LoginModel(this.name, this.email, this.pk, this.jwt, this.status);

  factory LoginModel.fromJson(Map<String, dynamic> json) => new LoginModel(
    json['name'],
    json['email'],
    json['pk'],
    json['jwt'],
    true,
    );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'pk': pk,
    'jwt': jwt,
  };
}