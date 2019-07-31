import 'dart:convert';

List<User> userFromJson(String str) => new List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userUniqueFromJson(String str) => new User.fromJson(json.decode(str));

String userToJson(List<User> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class  User {
  String name;
  String id;
  String phone;
  String email;
  String city;
  String adress;
  String indications;
  String pwd;

  User(
    this.name,
    this.id,
    this.phone,
    this.email,
    this.city,
    this.adress,
    this.indications,
    {this.pwd}
  );

  factory User.fromJson(Map<String, dynamic> json) => new User(
    json['name'],
    json['id'],
    json['phone'],
    json['email'],
    json['city'],
    json['adress'],
    json['indications'],
    pwd: json['pwd'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'phone': phone,
    'email': email,
    'city': city,
    'adress': adress,
    'indications': indications,
    'pwd': pwd,
  };
}