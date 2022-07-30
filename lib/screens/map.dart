import 'dart:async';

import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapDisp extends StatefulWidget{
  @override
  MapDispState createState() => MapDispState(); 

}

class MapDispState extends State<MapDisp>{
  @override
  Widget build(BuildContext context) {
      
      final dispositivoServicio = Provider.of<DispositivoServicio>(context);

      Completer<GoogleMapController> _controller = Completer();

      final CameraPosition _ubicacionInicial = CameraPosition(
        target: LatLng(dispositivoServicio.ubiActual.latitud, dispositivoServicio.ubiActual.longitud),
        zoom: 14.4749);

      return Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _ubicacionInicial),
      );
      
  }

}