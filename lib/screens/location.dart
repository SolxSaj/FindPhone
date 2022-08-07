import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/model/ubicacion.dart';
import 'package:findphone_vdos/model/usuario.dart';
import 'package:findphone_vdos/screens/dispositivowidget.dart';
import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';  
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class ShareLocation extends StatefulWidget{
  @override
  ShareLocationState createState() => ShareLocationState(); 

}

class ShareLocationState extends State<ShareLocation>{

  String location = "Null, press button";
  String address = "search";

  Future<Position> _determinePosition() async{
    bool serviceEnable;
    LocationPermission permission;

    setState(() {
      
    });

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      return Future.error("Location service is disabled.");
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permissions are denied.");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error("We cannot request permissions.");
    }

    return await Geolocator.getCurrentPosition();
  }
  
  @override
  Widget build(BuildContext context) {
    final dispositivoServicio = Provider.of<DispositivoServicio>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coordinates Points',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            ElevatedButton(onPressed: () async {
              Position position = await _determinePosition();

              location = 'Lat: ${position.latitude}, Lon: ${position.longitude}';

              Ubicacion tempUbi = Ubicacion(idUbicacion: dispositivoServicio.ubiActual.idUbicacion, idDispositivo: dispositivoServicio.ubiActual.idDispositivo, latitud: position.latitude, longitud: position.longitude);

              dispositivoServicio.updateUbicacion(tempUbi);
            }, child: Text('Get location'))
          ],
        )
      )
    );
  }

}

