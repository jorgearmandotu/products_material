import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../models/menu.dart';

class RowCant extends StatefulWidget {
  final Menu plato;
  RowCant(this.plato);
  _RowCantState createState() => _RowCantState(plato);
}

class _RowCantState extends State<RowCant> {
  Menu plato;
  _RowCantState(this.plato);
  int _cantidad = 1;
  @override
  void initState() {
    _cantidad = 1;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Material(
          child: IconButton(
            icon: Icon(Icons.remove),
              onPressed: (){
                setState(() {
                  if(_cantidad > 1) _cantidad--;
                });
              },
          ),
        ),
        Text(_cantidad.toString(),),
          Material(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                setState(() {
                  _cantidad++; 
                });
              },
            ),
          ),
        Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: (){},
          ),),
      ],
    );
  }
}