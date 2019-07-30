
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_material/helpers/saveDataUser.dart';
import 'package:products_material/models/login_model.dart';
import 'package:products_material/provider/user_provider.dart';
import 'package:provider/provider.dart';

class DrawerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    //final _user = Provider.of<UserProvider>(context);
    //print(_user.userEmail());
    
    return Consumer<UserProvider>(
      builder: (context, _user, child) {
        if( dataUser.getToken() != null){
          _user.loadUser();
        }
        return Drawer(
        //Consumer<UserProvider>(builder: (context, userinfo, _)=>Text(userinfo.userName()),), 
          child: _user.user.status != false ? 
          ListView(
            children: <Widget>[
              Text(_user.user.name),
              Text(_user.user.email),
              Text(_user.user.jwt),
              RaisedButton(
                child:  Text('logout'),
                onPressed: ()async {
                 _user.delUser();
                 await dataUser.deleteData();
                },
              )
            ],
          ):
          ListView(
            children: <Widget>[
              Text('No estas logueado')
            ],
          )
        );
      },
    );
  }
}

