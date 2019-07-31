import 'package:products_material/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDataUser {

  SharedPreferences _storage;
  setdata(LoginModel data,) async{
    try{
      _storage = await SharedPreferences.getInstance();
      _storage.setString('userName', data.name);
      _storage.setString('userEmail', data.email);
      _storage.setString('token', data.jwt);
      _storage.setString('pk', data.pk);
      return true;
    }catch(e){
      return false;
    }
  }

  deleteData() async {
    _storage = await SharedPreferences.getInstance();
    await _storage.remove('userName');
    await _storage.remove('userEmail');
    await _storage.remove('token');
    await _storage.remove('pk');
  }

  getuser() async {
    _storage = await SharedPreferences.getInstance();
    return  _storage.getString('userName') ?? null;
  }

  getEmail() async{
    _storage = await SharedPreferences.getInstance();
    return  _storage.getString('userEmail') ?? null;
  }

  getToken() async{
    _storage = await SharedPreferences.getInstance();
      return _storage.getString('token') ?? null;
  }
  getPk() async {
    _storage = await SharedPreferences.getInstance();
    return  _storage.getString('pk') ?? null;
  }

  getAllData() async{
    _storage = await SharedPreferences.getInstance();
    String name =  _storage.getString('userName');
    String email =  _storage.getString('userEmail');
    String pk =  _storage.getString('pk');
    String jwt =  _storage.getString('token');
    if(jwt == null) return LoginModel('name', 'email', 'pk', 'jwt', false);
    return LoginModel(name, email, pk, jwt, true);
  }
  loadData() async{
    _storage = await SharedPreferences.getInstance();
    LoginModel user = await getAllData();
    return user;
  }
}

SaveDataUser dataUser = new SaveDataUser();