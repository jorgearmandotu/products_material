import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:products_material/helpers/saveDataUser.dart';
import 'package:products_material/models/login_model.dart';
import 'package:products_material/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/menu.dart';
import '../models/category_products.dart';
import '../models/user.dart';
import '../models/request.dart';
import 'dart:io';
//import 'dart:convert';

class ApiService {
  String _url = 'https://www.desarrollodeapis.com/apirest/plato.php';

  Future<bool> statusConecction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future <List<Menu>> getMenu() async {
    print('get menu');
    final response  = await http.get(_url);
    List<Menu> data = menuFromJson(response.body);
    return data;
  }

  Future <List<Menu>> getMenuCategory(String category) async {
    print('get menucategory');
    final response = await http.get('$_url?category=$category');
    List<Menu> data;
    if(response.body.isNotEmpty){
      data = menuFromJson(response.body);
    }
    return data;
  }

  Future <List<CategoryProducts>> getCategories() async {
    print('get categories');
    final response = await http.get("https://www.desarrollodeapis.com/apirest/categories.php");
    List<CategoryProducts> data;
    if(response.body.isEmpty){
      data = null;
    }else{
      data = categoryFromJson(response.body);
    }
    return data;
  }

  Future<Request> insertUser(User user) async {
    final response = await http.post("https://www.desarrollodeapis.com/apirest/register.php", body: user.toJson());
    //print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      //registro ecxitoso
      return new Request(status: true, message: response.body);
      //return true;
    }
    else if(response.statusCode == 400){
      //fallo registro
      return new Request(status: false, message: response.body);
    }
    else{
      return new Request(status: false, message: 'status code: ${response.statusCode}, ${response.body}');
    }
  }

  Future<Request> login(String email, String pwd, BuildContext context) async {
    //Map<String, dynamic> data = new Map();
    //data = {'email':email, 'pwd':pwd};
    final response = await http.post('https://www.desarrollodeapis.com/apirest/login.php', body: {'email':email, 'pwd':pwd});
    if(response.statusCode == 200){
      //guardar token e incluirlo en el header :)
      //Map<String, dynamic> res = jsonDecode(response.body);
      //String d = '[${response.body}]';
      //List<LoginModel> data = loginFromJson(d);
      LoginModel data = loginUniqueFromJson(response.body);
      //print(dataUser.getEmail());
      var res = await dataUser.setdata(data);
      if(res){
        final _us = Provider.of<UserProvider>(context);
        _us.setuserProvider(data);
        return Request(status: true, message: 'Login exitoso');
      }else{
        return Request(status: false, message: 'No se pudo guardar datos');
      }
    }else if(response.statusCode == 400){
      return new Request(status: false, message: response.body);
    }else{
      return Request(status: false, message:  'status code: ${response.statusCode}, ${response.body}');
    }
  }

  Future<User> dataProfile() async{
    String token = await dataUser.getToken();
    
    final response = await http.post('https://www.desarrollodeapis.com/apirest/profile.php',headers: {HttpHeaders.authorizationHeader:token});
    if(response.statusCode == 200){
      User data = userUniqueFromJson(response.body);
      return data;
      //return Request(status: true, message: response.body);
    }
    //return Request(status: false, message: 'No estas logeuado');
    return null;
  }

}

/*500 (server issue)
401 (token auth missing or incorrect or no such credentials any more)
404 (missing resource)
403 (authenticated but insufficient permission for action )
405 (method not allowed — when you try to access a POST with a GET etc.)
400 (bad request — for example if you don’t submit username and password fields to login)*/