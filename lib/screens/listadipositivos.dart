import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/model/usuario.dart';
import 'package:findphone_vdos/screens/dispositivowidget.dart';
import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ListaDispositivos extends StatefulWidget{

  ListaDispositivos({Key? key}) : super(key: key);

  @override
  ListaDispositivosState createState() => ListaDispositivosState();
}

class ListaDispositivosState extends State<ListaDispositivos>{

  ScrollController _scrollController = ScrollController();
  TextEditingController _dispositivoController = TextEditingController();

  @override
  Widget build(BuildContext context){

    final dispositivoServicio = Provider.of<DispositivoServicio>(context);



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bienvenido " + dispositivoServicio.userActual.nombre + dispositivoServicio.userActual.apellido, style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 43, 167, 200),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.construction_rounded, color: Colors.white),
            onPressed: (){

            }),
          IconButton(
            icon: const Icon(Icons.update, color: Colors.white),
            onPressed: (){
              dispositivoServicio.ListaDispositivos();
            },
          )
        ],
      ),
      body:ListView.builder(
        itemCount: dispositivoServicio.dispositivos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            dispositivoServicio.dispSeleccionado = dispositivoServicio.dispositivos[index].copy();
            //Navigator.pushNamed(context, "");
          },
          child: DispositivoWidget(disp: dispositivoServicio.dispositivos[index])
        ),
      ),
    );
  }

}