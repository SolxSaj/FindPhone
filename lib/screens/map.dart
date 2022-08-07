import 'dart:async';

import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDisp extends StatefulWidget{
  @override
  MapDispState createState() => MapDispState(); 

}

class MapDispState extends State<MapDisp>{

  @override
  Widget build(BuildContext context) {
      
      final dispositivoServicio = Provider.of<DispositivoServicio>(context);

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 167, 200),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_city, color: Colors.white),
            onPressed: () async{
              await dispositivoServicio.obtenerUbicacion();
            },
          ),
        ],
      ),
      body: Container(
        child: FlutterMap(
        options: MapOptions(
            center: LatLng( dispositivoServicio.ubiActual.latitud, dispositivoServicio.ubiActual.longitud),
            zoom: 14.0,
        ),
        layers: [
            TileLayerOptions(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.app',
            ),
        ],
        nonRotatedChildren: [
            AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
            ),
        ],
   ),
      )
   );
      
  }

}