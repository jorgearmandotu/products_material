
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormRegister extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Registro'),
      ),
      body: Text('registro'),
    );
  }
}

class RegisterNewUser extends StatefulWidget {
@override
_RegisterNewUserState createState() => _RegisterNewUserState();
}

class _RegisterNewUserState extends State<RegisterNewUser> {
  final keyRegisterUser = GlobalKey<FormState>();
  @override
  Widget build(Buildcontext) {
    return Form(
      key: keyRegisterUser,
      autovalidate: true,
      child: formUser(),
    );
  }

  Widget formUser() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: <Widget>[
        TextFormField(
          textCapitalization: TextCapitalization.words,
          obscureText: true,
          validator: (value){
            if(value.isEmpty){
              return 'ingrese nombre';
            }
          }
        ),
      ],
    );
  }
}