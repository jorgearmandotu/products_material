import 'package:http/http.dart' as http;
import '../models/menu.dart';
import '../models/category_products.dart';
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

}