import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationMap extends StatefulWidget {
  @override
  State<LocationMap> createState()=> LocationMapState();
}

class LocationMapState extends State<LocationMap> {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(1.20391, -77.277186), zoom: 15.0);

  Position position;

  Future getLocation() async{ 
    
    try{
      await Geolocator().checkGeolocationPermissionStatus();
      //position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      //print('latitud: ${position.latitude.toString()}  *** longitud: ${position.longitude.toString()}');
     /*setState(() {
       //_initialPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 20.0);
     });*/
    } on PlatformException catch (e){
      print('Error:');
      print(e.details);
      position = null;
    }
  }
  
  @override
  initState(){
    getLocation();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('tu ubicación'),
        centerTitle: true,
      ),*/
      body: Stack(
        children: <Widget>[
          (_initialPosition != null) ?
          GoogleMap(    
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true ,
          ) : Text('no hay data'),
        ],
      ));
  }
}