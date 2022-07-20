import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:flutter/material.dart';

class DispositivoWidget extends StatelessWidget{
  final Dispositivo disp;

  const DispositivoWidget({Key? key, required this.disp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
    color: Color.fromARGB(255, 57, 57, 57),
    // Con esta propiedad modificamos la forma de nuestro card
    // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    
    // Con esta propiedad agregamos margen a nuestro Card
    // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
    margin: EdgeInsets.all(15),
    
    // Con esta propiedad agregamos elevación a nuestro card
    // La sombra que tiene el Card aumentará
    elevation: 10,

    // La propiedad child anida un widget en su interior
    // Usamos columna para ordenar un ListTile y una fila con botones
    child: Column(
      children: <Widget>[

        // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text(disp.modelo, style: TextStyle(color: Colors.white)),
          subtitle: Text(disp.marca, style: TextStyle(color: Colors.white)),
          leading: Icon(Icons.phone_android, color: Colors.white),
        ),
        
        // Usamos una fila para ordenar los botones del card
      ],
    ),
  );
}
}