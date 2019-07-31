import 'package:flutter/material.dart';

import '../models/request.dart';
import '../models/user.dart';
import '../models/category_products.dart';
import '../models/menu.dart';
import 'package:rxdart/rxdart.dart';
import '../services/api_service.dart';

class BlocMenu {
  ApiService _apiService = new ApiService();
  BehaviorSubject<List<Menu>> _listMenus = BehaviorSubject<List<Menu>>();
  Observable<List<Menu>> get allMenu => _listMenus.stream;

  BehaviorSubject<List<CategoryProducts>> _listCategories;// = BehaviorSubject<List<CategoryProducts>>();
  Observable<List<CategoryProducts>> get allCategories => _listCategories.stream;

  fetchAllMenu({String idMenu}) async {
    if(idMenu != null){

    }else{
      if( await _apiService.statusConecction()){
        _listMenus.sink.add(await _apiService.getMenu());
      }
    }
  }

  fetchAllCategories() async {
    if(await _apiService.statusConecction()){
      _listCategories.sink.add(await _apiService.getCategories());
    }
  }

  void open(){
    _listMenus = BehaviorSubject<List<Menu>>();
    _listCategories = BehaviorSubject<List<CategoryProducts>>();
  }

  Future<Request> registerUser(User user) async{
    return await (_apiService.insertUser(user));
  }

  Future<Request> login(String email, String pwd, BuildContext context) async{
    return await _apiService.login(email, pwd, context);
  }

  void dispose(){
    _listMenus.close();
    _listCategories.close();
  }
}

final blocMenu = BlocMenu();