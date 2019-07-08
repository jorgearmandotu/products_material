
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class FormRegister extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Registro'),
      ),
      body: RegisterNewUser(),
    );
  }
}

class RegisterNewUser extends StatefulWidget {
@override
_RegisterNewUserState createState() => _RegisterNewUserState();
}

class _RegisterNewUserState extends State<RegisterNewUser> {
  final keyRegisterUser = GlobalKey<FormState>();

  String _city;
  List<DropdownMenuItem<String>> _listCity = [
    DropdownMenuItem(
      child: Text('pasto'),
      value: 'Pasto',)
  ];

  @override
  Widget build(context) {
    return Form(
      key: keyRegisterUser,
      autovalidate: true,
      child: formUser(),
    );
  }

  Widget formUser() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.0,),
      children: <Widget>[
        TextFormField(//nombre
          decoration: InputDecoration(
            labelText: 'Nombre:',
            helperText: 'Ingrese su nombre.',
            enabledBorder: styleBorder(),
            focusedBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            ),
          validator: (value){
            if(value.isEmpty){
              return 'ingrese nombre';
            }
          }
        ),
        TextFormField(//identificacion para factura
          decoration: InputDecoration(
            labelText: 'Identificacion:',
            helperText: 'Ingrese numero de identificación',
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
          ),
          validator: (value){
            if(value.isEmpty) return 'Ingrese Numero de Identificación';
          },
        ),
        TextFormField(//telefono
        keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Telefono:',
            helperText: 'Ingrese numerp Telefono/Celular.',
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
          ),
          validator: (value){
            if(value.isEmpty) return 'Ingrese Numero de Telefono';
          },
        ),
        TextFormField(//email
        keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            labelText: 'Email:',
            helperText: 'Ingrese correo electronico.'
          ),
          validator: (value){
            String expresion = "/^[a-zA-Z0-9.!#\$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$/";
            String expresionEmail = "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*\$";
            if(value.isEmpty){
              return 'Ingrese datos validos';
            }else if(RegExp(expresionEmail).hasMatch(value)){
              return 'Ingrese Email Valido';
            }
          },
        ),
        Container(
          
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.amber,
            
          ),
          child: DropdownButton<String>(
          
          hint: Text('Seleccione Ciudad'),
          items: _listCity,
          value: _city,
          onChanged: (value){
            setState(() {
             _city = value; 
            });
          },
        ),
        ),
        
        TextFormField(//adress
        keyboardAppearance: Brightness.dark,
          decoration: InputDecoration(
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            labelText: 'Direccion:',
            helperText: 'Direccion de domicilio',
            ),
        ),
        TextFormField(//complemento addres
          decoration: InputDecoration(
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            labelText: 'datos extra de direccion',
            helperText: 'casa, apto, frente a...'
          ),
        ),
        CupertinoButton(
          child: Text('Registrar'),
          color: Colors.lightBlue,
          pressedOpacity: 0.5,
          borderRadius: BorderRadius.circular(30.0),
          onPressed: (){},
        ),
      ],
    );
  }

  OutlineInputBorder styleBorder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.blueGrey,
        width: 1.8,
      ),
    );
  }

  OutlineInputBorder styleBorderError(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.red,
        width: 1.8,
      ),
    );
  }
}

