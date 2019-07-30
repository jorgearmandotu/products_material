import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:products_material/helpers/saveDataUser.dart';
import 'package:products_material/ui/widgets/descriptionHero.dart';
import 'package:products_material/ui/widgets/drawer_user.dart';
import '../../models/menu.dart';
import '../../models/category_products.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';
import '../../bloc/bloc_menu.dart';
import 'dart:async';
import '../../helpers/helperFormat.dart';
import '../widgets/rowCant.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.create),
        middle: Text('Menu'),
        trailing: Icon(CupertinoIcons.gear_solid),
      ),
      body: CategoriesView(),
      
    );
    /*return Container(
      height: MediaQuery.of(context).size.height,
      child: CategoriesView(),
    );*/
     
  }
}

class CategoriesView extends StatefulWidget {
  @override
  CategoriesViewState createState(){
    return CategoriesViewState();
  }
}

class CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    blocMenu.open();
    blocMenu.fetchAllMenu();
    blocMenu.fetchAllCategories();
    
    super.initState();
  }
  void dispose(){
    blocMenu.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async{
    try{
      blocMenu.dispose();
      blocMenu.open();
      await blocMenu.fetchAllMenu();
      await blocMenu.fetchAllCategories();
      return blocMenu.allCategories;
    } catch (e){
      return false;
    }
    
  }

  @override
  Widget build(BuildContext context){
    return RefreshIndicator(
      onRefresh: (){
        Future<void> res = _onRefresh();
        return res;
      },
      child: StreamBuilder(
        stream: blocMenu.allCategories,
        builder: (context, AsyncSnapshot<List<CategoryProducts>>snapshot){
        //construir listview de acuerdo a categorias y en ellas cargar menu de cada acategoria
          if(snapshot.hasData){
            return buildCategories(snapshot);
          }else if(snapshot.hasError)
          {
            return Text(snapshot.error.toString());
          }else if(snapshot.connectionState == ConnectionState.none){
            return Center(child: Text('upps no hemos podico conectarnos con el servidor'),);
          }
          return Center(child: CupertinoActivityIndicator(radius: MediaQuery.of(context).size.width * 0.05));
        },
      ),
    );
  }

  Widget buildCategories(AsyncSnapshot<List<CategoryProducts>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, index){
        CategoryProducts category = snapshot.data[index];
        return StreamBuilder(
          stream: blocMenu.allMenu,
          builder: (context, AsyncSnapshot<List<Menu>> snapshotMenu){
            if(snapshotMenu.hasData){
              return Column(
                children: <Widget>[
                  Text(category.category, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  ListMenu(category, snapshotMenu),
                ],
              );
            }else if(snapshotMenu.hasError){
              return Text(snapshotMenu.error.toString());
            }
            return CupertinoActivityIndicator();
          },
        );
      },
    );
  }
}

class ListMenu extends StatefulWidget {
  final CategoryProducts category;
  final AsyncSnapshot<List<Menu>> snapshot;
  ListMenu(this.category, this.snapshot);
  @override
  ListMenuState createState(){
    return ListMenuState(category, snapshot);
  }
}

class ListMenuState extends State<ListMenu>{
  CategoryProducts category;
  AsyncSnapshot<List<Menu>> snapshot;

  ListMenuState(this.category, this.snapshot);
  @override
  Widget build( context){
    return StreamBuilder(
      stream: blocMenu.allMenu,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return buildListMenu(snapshot);
        }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return CupertinoActivityIndicator();
      },
    );
  }

  Widget buildListMenu(AsyncSnapshot<List<Menu>> snapshot){
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height*0.36 : MediaQuery.of(context).size.height*0.95,),
      child: ListView.builder(
        itemCount: snapshot.data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          Menu plato = snapshot.data[index];
          if(category.id == plato.category){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DescriptionHero(plato)));
              },
              child: cardMenu(plato),
            );
          }
          else{
            return Container();
          }
        },
      )
    ); 
  }
//refreshindicator envolver para poder recargar items
  Widget cardMenu(Menu plato){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.width*0.37,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(plato.image),
                  fit: BoxFit.cover,
                )
              ),
            )
          ),
          Text(plato.name),
          Row(
            children: <Widget>[
              Text(money.format(plato.price)),
              IconButton(
                icon: Icon(Icons.add_shopping_cart,),
                onPressed: (){
                  showDialog(context: context, builder: (context){
                    return dialogDescription(plato);//DialogPedido(plato);
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget dialogDescription(Menu plato){
    int cantidad = 1;
    return CupertinoAlertDialog(
      title: Text(plato.name),
      content: Column(
        children: <Widget>[
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Material(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    cantidad--;
                  },
                ),
              ),
              Text(cantidad.toString(),),
              Material(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    cantidad++;
                  },
                ),
              ),
              Material(
            color: Colors.transparent,
            child: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: (){},
          ),)
            ],
          ),*/
          RowCant(plato),
        ],
      ),
    );
  }
}

class DialogPedido extends StatefulWidget {
  final Menu plato;
  DialogPedido(this.plato);
  _DialogPedidoState createState() => _DialogPedidoState(plato);
}

class _DialogPedidoState extends State<DialogPedido> {
  Menu plato;
  _DialogPedidoState(this.plato);
  int _cantidad = 1;
  @override
  void initState() {
    _cantidad = 1;
    super.initState();
  }
  
  @override
  Widget build(BuildContext) {
    return CupertinoAlertDialog(
      title: Text(plato.name),
      content: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Material(
                child: IconButton(
                  icon: Icon(Icons.add),
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
          ),)
            ],
          ),
          
        ],
      ),
    );
  }
}