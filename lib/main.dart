import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:products_material/provider/user_provider.dart';
import 'package:products_material/ui/widgets/MainView.dart';
import 'package:products_material/ui/widgets/detailsUser.dart';
import 'package:products_material/ui/widgets/drawer_user.dart';
import 'package:products_material/ui/widgets/locationMap.dart';
import 'package:provider/provider.dart';
import 'ui/widgets/form_login.dart';
import 'ui/widgets/form_register.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  //validar si esta login o logout
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserProvider(),
      child: MaterialApp(
        title: 'menu',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NavigatorBar(),
      ),
    );
  }
}

class NavigatorBar extends StatefulWidget {
  NavigatorBar({Key key}) : super(key:key);
  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selected = 0;
  List<Widget> _widgetOptions = <Widget>[
    MainView(),
    FormRegister(),//page 2
    LocationMap(),//pague 3
    FormLogin(),
    DetailsUser(),
  ];

  void _onTapped(int index){
    setState(() {
     _selected = index; 
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: DrawerUser(),
      body: _widgetOptions.elementAt(_selected),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home, color: Colors.red,),
            activeIcon: Icon(CupertinoIcons.home, color: Colors.redAccent), 
            title: Text('home'),
            ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_add, color: Colors.red,),
            activeIcon: Icon(CupertinoIcons.person, color: Colors.redAccent),
            title: Text('user'),
            ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.play_arrow, color: Colors.red,),
            activeIcon: Icon(CupertinoIcons.play_arrow, color: Colors.redAccent), 
            title: Text('settings'),
            ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person, color: Colors.red,),
            activeIcon: Icon(CupertinoIcons.play_arrow, color: Colors.redAccent),
            title: Text('Login'),
            ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone_solid, color: Colors.red,),
            activeIcon: Icon(CupertinoIcons.phone, color: Colors.redAccent),
            title: Text('detailUser'),
            ),
        ],
        currentIndex: _selected,
        selectedItemColor: Colors.amber[800],
        onTap: _onTapped,
      ),
    );
  }
}