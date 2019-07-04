import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:products_material/ui/widgets/rowCant.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../models/menu.dart';

class DescriptionHero extends StatelessWidget {
  final Menu plato;
  DescriptionHero(this.plato);
  @override
  Widget build(context){
    return Scaffold(
      /*navigationBar: CupertinoNavigationBar(
        middle: Text('Detalles'),
        singelchildScrollview
      ),*/
      appBar: CupertinoNavigationBar(
        middle: Text(plato.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic), overflow: TextOverflow.ellipsis,),
      ),
      body: ListView(
        children: <Widget>[
          FadeInImage.assetNetwork(
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: kTransparentImage.toString(),
            image: plato.image,
          ),
          //Text(plato.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: <Widget>[
                  Text(plato.description, textAlign: TextAlign.justify,),
                  RowCant(plato),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}