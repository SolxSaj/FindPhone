import 'dart:convert';
import 'dart:io';

import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
//import 'package:imei_plugin/imei_plugin.dart';

class DispositivoServicio extends ChangeNotifier{

  final String _baseURL = 'findphoneflutter-default-rtdb.firebaseio.com';
  List<Dispositivo> dispositivos = [];
  bool isLoading = true;
  bool isSaving = false;
  late Dispositivo dispSeleccionado;
  late Usuario userActual;


  DispositivoServicio(){
    this.ListaDispositivos();
    userActual = Usuario(apellido: " ", email: " ", nombre: " ", password: " ", idUsuario: "Nulo");
  }

  Future<List<Dispositivo>> ListaDispositivos() async{
      this.isLoading = true;
      notifyListeners();

      if(dispositivos.length != 0){
        dispositivos = [];
      }

      final url = Uri.https(_baseURL, 'dispositivo.json');
      final response = await http.get(url);
      final Map<String, dynamic> mapDisp = json.decode(response.body);


      mapDisp.forEach((key, value) { 
        if(value['idUsuario'] == this.userActual.idUsuario){  
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

  Future<Usuario> ValidarUsuario(String email, String password) async{
      this.isLoading = true;
      notifyListeners();

      final url = Uri.https(_baseURL, 'usuario.json');
      final response = await http.get(url);
      final Map<String, dynamic> mapDisp = json.decode(response.body);
      this.userActual = Usuario(apellido: " ", email: " ", nombre: " ", password: " ", idUsuario: "Nulo");


      mapDisp.forEach((key, value) {
        if(value['email'] == email && value['password'] == password){
          final tempUser = Usuario.fromMap(value);
          tempUser.idUsuario = key;
          this.userActual = tempUser;
        }
      });

      this.isLoading = false;
      notifyListeners();

      return this.userActual;

  }

  Future<void> LimpiarUsuario() async{
    this.userActual = Usuario(apellido: " ", email: " ", nombre: " ", password: " ", idUsuario: "Nulo");
  }

  Future<void> CompDispo(String idUser) async{
    isLoading = true;
    notifyListeners();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool existe = false;
    //String imei = await ImeiPlugin.getImei();

    String model = androidInfo.brand! + " " + androidInfo.device!;
    Dispositivo dispTemp = Dispositivo(idUsuario: idUser, imei: "123456789a", marca: androidInfo.manufacturer!, modelo: model);

    final url = Uri.https(_baseURL, 'dispositivo.json');
    final response = await http.get(url);
    final Map<String, dynamic> mapDisp = json.decode(response.body);


      mapDisp.forEach((key, value) { 
        if(value['imei'] == dispTemp.imei && value['idUsuario'] == dispTemp.idUsuario){  
          existe = true;
        }
      });

    if(existe == false){
      crear(dispTemp);
    }

    isLoading = false;
    notifyListeners();
  }

}

