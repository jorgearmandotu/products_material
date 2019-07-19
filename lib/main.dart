import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:products_material/ui/widgets/MainView.dart';
import 'package:flutter/services.dart';
import 'package:products_material/ui/widgets/locationMap.dart';
import 'ui/widgets/form_login.dart';
import 'ui/widgets/form_register.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _NavigatorBar(),
    );
  }
}

class _NavigatorBar extends StatefulWidget {
  _NavigatorBar({Key key}) : super(key:key);
  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<_NavigatorBar> {
  int _selected = 0;
  List<Widget> _widgetOptions = <Widget>[
    MainView(),
    FormRegister(),//page 2
    LocationMap(),//pague 3
    FormLogin(),
  ];

  void _onTapped(int index){
    setState(() {
     _selected = index; 
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
        ],
        currentIndex: _selected,
        selectedItemColor: Colors.amber[800],
        onTap: _onTapped,
      ),
    );
  }
}