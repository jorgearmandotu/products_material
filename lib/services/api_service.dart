import 'package:http/http.dart' as http;
import 'package:products_material/models/request.dart' as prefix0;
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
      return new prefix0.Request(status: false, message: 'status code: ${response.statusCode}, ${response.body}');
    }
  }

  Future login(String email, String pwd) async {
    print('login');
    final response = await http.post('https://www.desarrollodeapis.com/apirest/login.php', body: {email:email, pwd:pwd});
    print(response.body);
    if(response.statusCode == 200){
      //guardar token e incluirlo en el header :)
    }else if(response.statusCode == 400){
      return new prefix0.Request(status: false, message: response.body);
    }else{
      return prefix0.Request(status: false, message:  'status code: ${response.statusCode}, ${response.body}');
    }
  }

}