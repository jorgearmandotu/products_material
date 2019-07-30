import 'package:flutter/material.dart';
import 'package:products_material/helpers/saveDataUser.dart';
import 'package:products_material/models/login_model.dart';

class UserProvider extends ChangeNotifier {
  
  LoginModel user = new LoginModel('no loguin', 'name@...', 'pk', 'jwt', false);  

  setuserProvider(LoginModel user){
    this.user = user;
    notifyListeners();
  }

  userName(){
    return user.name;
  }
  userEmail(){
    return user.email;
  }

  userPk(){
    return user.pk;
  }
  userToken(){
    return user.jwt;
  }

  loadUser() async{
    //busco datos en preference si ecxiste cargo datos
    LoginModel usuario = await dataUser.loadData();
    setuserProvider(usuario);
  }

  delUser(){
    setuserProvider(new LoginModel('no loguin', 'name@...', 'pk', 'jwt', false));
  }
}
