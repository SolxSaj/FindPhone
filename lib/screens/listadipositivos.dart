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
      appBar: AppBar(title: const Text("Dispositivos")),
      body: ListView.builder(
        itemCount: dispositivoServicio.dispositivos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            dispositivoServicio.dispSeleccionado = dispositivoServicio.dispositivos[index].copy();
            Navigator.pushNamed(context, "");
          },
          child: DispositivoWidget(disp: dispositivoServicio.dispositivos[index])
        ),
      ),
    );
  }

}