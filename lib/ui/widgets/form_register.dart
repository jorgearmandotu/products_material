import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:products_material/bloc/bloc_menu.dart';
import 'package:products_material/models/user.dart';
import 'package:products_material/ui/widgets/form_login.dart';
import './helper/borders.dart';

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
  final _keyRegisterUser = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _adress = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _indications = TextEditingController();
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

  String _city;
  List<DropdownMenuItem<String>> _listCity = [
    DropdownMenuItem(
      child: Text('pasto'),
      value: 'Pasto',),
    DropdownMenuItem(
      child: Text('Ipiales'),
      value: 'Ipiales',),
  ];

  @override
  Widget build(context) {
    return Form(
      key: _keyRegisterUser,
      autovalidate: true,
      child: formUser(),
    );
  }

  Widget formUser() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: <Widget>[
        TextFormField(//nombre
          controller: _name,
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
            return null;
          }
        ),
        TextFormField(//identificacion para factura
          controller: _id,
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
            return null;
          },
        ),
        TextFormField(//telefono
          controller: _phone,
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
            return null;
          },
        ),
        TextFormField(//email
        controller: _email,
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
            if(value.isEmpty){
              return 'Ingrese datos validos';
            }
            RegExp email =  RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
            if(email.hasMatch(value.toString()) == false){
              return 'Ingrese Email Valido';
            }
            return null;
          },
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.blueGrey, style: BorderStyle.solid),
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
        Container(
          margin: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: Colors.blueGrey, style: BorderStyle.solid)
          ),
          child: IconButton(icon: Icon(Icons.location_searching), tooltip: 'ubicación', onPressed: (){},),
        )
        ],),
        TextFormField(//adress
          controller: _adress,
          decoration: InputDecoration(
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            labelText: 'Direccion:',
            helperText: 'Direccion de domicilio',
            ),
            validator: (value){
              if(value.isEmpty){
                return 'Ingrese datos validos';
              }
              return null;
            },
        ),
        TextFormField(//complemento addres
          controller: _indications,
          decoration: InputDecoration(
            focusedBorder: styleBorder(),
            enabledBorder: styleBorder(),
            errorBorder: styleBorderError(),
            focusedErrorBorder: styleBorderError(),
            labelText: 'datos extra de direccion',
            helperText: 'casa, apto, frente a...'
          ),
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
            return null;
          },
        ),
        CupertinoButton(
          child: Text('Registrar'),
          color: Colors.lightBlue,
          pressedOpacity: 0.5,
          borderRadius: BorderRadius.circular(30.0),
          onPressed: ()async{
            if(_keyRegisterUser.currentState.validate() && _city != null){
              String name = _name.text;
              String id = _id.text;
              String phone = _phone.text;
              String email = _email.text;
              String city = _city;
              String adress = _adress.text;
              String indications = _indications.text;
              String pwd = _pwd.text;
              User user = new User(name, id, phone, email, city, adress, indications, pwd: pwd);
              
              blocMenu.registerUser(user).then((value){
                if(value.status){
                  //redirecciona a inicio y se loguea
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormLogin()),
                  );
                }
                else{
                  return showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Error'), content: Text(value.message),));
                }
              });
            }else {
              return showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Error!'), content: Text('Upps!, algo salio mal verifique datos.'), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),));
            }
          },
        ),
      ],
    );
  }
}

