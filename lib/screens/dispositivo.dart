import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DispositivoEspecifico extends StatefulWidget{

  
  DispositivoEspecifico({Key? key}) : super(key: key);

  @override
  DispositivoEspecificoState createState() => DispositivoEspecificoState();

}

class DispositivoEspecificoState extends State<DispositivoEspecifico>{
  @override
  Widget build(BuildContext context) {

    final dispositivoServicio = Provider.of<DispositivoServicio>(context);

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(dispositivoServicio.dispSeleccionado.idUsuario),
              Text(dispositivoServicio.dispSeleccionado.imei),
              Text(dispositivoServicio.dispSeleccionado.marca),
              Text(dispositivoServicio.dispSeleccionado.modelo)
            ],
            )
        ),
      ),
    );
  }

}