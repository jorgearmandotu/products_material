import '../models/request.dart';
import '../models/user.dart';
import '../models/category_products.dart';
import '../models/menu.dart';
import 'package:rxdart/rxdart.dart';
import '../services/api_service.dart';

class BlocMenu {
  ApiService apiService = new ApiService();
  BehaviorSubject<List<Menu>> _listMenus = BehaviorSubject<List<Menu>>();
  Observable<List<Menu>> get allMenu => _listMenus.stream;

  BehaviorSubject<List<CategoryProducts>> _listCategories;// = BehaviorSubject<List<CategoryProducts>>();
  Observable<List<CategoryProducts>> get allCategories => _listCategories.stream;

  fetchAllMenu({String idMenu}) async {
    if(idMenu != null){

    }else{
      if( await apiService.statusConecction()){
        _listMenus.sink.add(await apiService.getMenu());
      }
    }
  }

  fetchAllCategories() async {
    if(await apiService.statusConecction()){
      _listCategories.sink.add(await apiService.getCategories());
    }
  }

  void open(){
    _listMenus = BehaviorSubject<List<Menu>>();
    _listCategories = BehaviorSubject<List<CategoryProducts>>();
  }

  Future<Request> registerUser(User user) async{
    return await (apiService.insertUser(user));
  }

  Future login(String email, String pwd) async{
    return await (apiService.login(email, pwd));
  }

  void dispose(){
    _listMenus.close();
    _listCategories.close();
  }
}

final blocMenu = BlocMenu();