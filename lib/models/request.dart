import 'dart:convert';

import 'package:products_material/models/login_model.dart';

List<Request> requestFromJson(String str) => new List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestToJson(List<Request> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  bool status;
  String message;

  Request({
    this.status,
    this.message,
  });

  factory Request.fromJson(Map<String, dynamic> json) => new Request(
    status: json['status'],
    message: json['message'],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}