import 'dart:convert';
import 'dart:io';

import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DispositivoServicio extends ChangeNotifier{

  final String _baseURL = 'findphoneflutter-default-rtdb.firebaseio.com';
  final List<Dispositivo> dispositivos = [];
  bool isLoading = true;
  bool isSaving = false;
  late Dispositivo dispSeleccionado;


  DispositivoServicio(){
    this.ListaDispositivos();
  }

  Future<List<Dispositivo>> ListaDispositivos() async{
      this.isLoading = true;
      notifyListeners();

      final url = Uri.https(_baseURL, 'dispositivo.json');
      final response = await http.get(url);
      final Map<String, dynamic> mapDisp = json.decode(response.body);


      mapDisp.forEach((key, value) { 
        if(value['idUsuario'] == "car123"){  
          final tempDisp = Dispositivo.fromMap(value);
          tempDisp.idDispositivo = key;
          this.dispositivos.add(tempDisp);
        }
      });

      this.isLoading = false;
      notifyListeners();
      
      return this.dispositivos;

  }
  
  Future creActualizacion(Dispositivo dispositivo) async{

    this.isSaving = true;
    notifyListeners();

    if(dispositivo.idDispositivo == null){
        await crear(dispositivo);
    }else{
        await update(dispositivo);
    }

    this.isSaving = false;
    notifyListeners();

  }

  Future<String> crear(Dispositivo dispositivo) async{

    final url = Uri.https(_baseURL, 'dispositivo.json');
    final response = await http.post(url, body: dispositivo.toJson());

    final datos = json.decode(response.body);

    dispositivo.idDispositivo = datos['name'];

    this.dispositivos.add(dispositivo);

    return "Dispositivo añadido";
  }

  Future<String> update(Dispositivo dispositivo) async{

    final url = Uri.https(_baseURL, 'dispositivo.json');
    final response = await http.put(url, body: dispositivo.toJson());

    final datos = json.decode(response.body);

    final index = this.dispositivos.indexWhere((element) => element.idDispositivo == dispositivo.idDispositivo);

    this.dispositivos[index] = dispositivo;

    return "Dispositivo actualizado";

  }

  Future<String> delete(Dispositivo dispositivo) async{

    this.isSaving = true;
    notifyListeners();

    final url = Uri.https(_baseURL, 'dispositivo.json');
    final response = await http.delete(url);

    final datos = json.decode(response.body);

    final index = this.dispositivos.indexWhere((element) => element.idDispositivo == dispositivo.idDispositivo);

    this.dispositivos.removeAt(index);

    this.isSaving = false;
    notifyListeners();

    return "Dispositivo actualizado";

  }


}

