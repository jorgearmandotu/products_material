
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_material/services/api_service.dart';

class DetailsUser extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('LogIn'),
      ),
      body: Details(),
    );
  }
}

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  String name = 'DUMY';
  String email= 'DUMY';
  String phone= 'DUMY';
  String city= 'DUMY';
  String adress= 'DUMY';
  String indications= 'DUMY';
  String id;
  ApiService apiservice = new ApiService();
  @override
  void initState() {
    // TODO: implement initState
    apiservice.dataProfile();
    super.initState();
  }
  @override
  Widget build(context) {
    return ListView(
      children: <Widget>[
        Text(name),
        Text(email),
        Text(phone),
        Text(city),
        Text(adress),
        Text(indications),
        Text(id),
      ],
    );
  }
}