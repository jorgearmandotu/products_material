import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './helper/borders.dart';

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('LogIn'),
      ),
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
    @override
    _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _keyLoginForm = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  @override
  initState(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(context) {
    return Form(
      key: _keyLoginForm,
      autovalidate: true,
      child: formLogin(),
      );
  }

  Widget formLogin(){
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      children: <Widget>[
        TextFormField(
          controller: _email,
          decoration:  InputDecoration(
            labelText: 'Email:',
            helperText: 'Ingrese su Email.',
            enabledBorder: styleBorder(),
            focusedBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
          ),
          validator: (value){
            if(value.isEmpty){
              return 'Ingrese datos validos';
            }
            RegExp emailUnicode = RegExp(r'/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/');
            RegExp email =  RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
            print(emailUnicode.hasMatch(value.toString()));
            print(email.hasMatch(value.toString()));
            print(value.toString());
            if(email.hasMatch(value.toString()) == false){
              return 'Ingrese Email Valido';
            }
          },
        ),
        TextFormField(//pwd
          controller: _pwd,
          decoration: InputDecoration(
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            labelText: 'contraseña',
            helperText: 'contraseña.'
          ),
          obscureText: true,
          validator: (value){
            if(value.isEmpty) return 'Ingrese Contraseña';
          },
        ),
        RaisedButton(
          child: Text('Ingresar', style: TextStyle(color: Colors.white),),
          color: Colors.lightBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: (){
            //loguear
            
          },
        )
      ],
    );
  }
}