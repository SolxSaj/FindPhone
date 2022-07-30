import 'dart:convert';
import 'dart:io';

import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/model/ubicacion.dart';
import 'package:findphone_vdos/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unique_identifier/unique_identifier.dart';

class DispositivoServicio extends ChangeNotifier{

  final String _baseURL = 'findphoneflutter-default-rtdb.firebaseio.com';
  List<Dispositivo> dispositivos = [];
  bool isLoading = true;
  bool isSaving = false;
  late Dispositivo dispSeleccionado;
  late Usuario userActual;
  late Ubicacion ubiActual;
  late Dispositivo dispActual;


  DispositivoServicio(){
    this.solicitarPermisos();
    this.ListaDispositivos();
    dispActual = Dispositivo(idUsuario: "", imei: "nulo", marca: "", modelo: "");
    this.ObtenerActual();
    userActual = Usuario(apellido: " ", email: " ", nombre: " ", password: " ", idUsuario: "Nulo");
  }

//Permisos

Future<void> solicitarPermisos() async{
  Map<Permission, PermissionStatus> statuses = await[
    Permission.location,
    Permission.sensors,
  ].request();
}

//Funciones de dispositivos

  Future<void> ObtenerActual() async {
      this.isLoading = true;
      notifyListeners();

      final url = Uri.https(_baseURL, 'dispositivo.json');
      final response = await http.get(url);
      final Map<String, dynamic> mapDisp = json.decode(response.body);
      String? imei;

      imei = await UniqueIdentifier.serial;

      mapDisp.forEach((key, value) { 
        if(value['imei'] == imei){  
          final tempDisp = Dispositivo.fromMap(value);
          tempDisp.idDispositivo = key;
          this.dispActual = tempDisp;
        }
      });

      print(this.dispActual.idDispositivo);
      this.isLoading = false;
      notifyListeners();
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

//Funciones de usuarios

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
    String? imei;

    imei = await UniqueIdentifier.serial;
    
    print(imei);

    String model = androidInfo.brand! + " " + androidInfo.device!;
    Dispositivo dispTemp = Dispositivo(idUsuario: idUser, imei: imei!, marca: androidInfo.manufacturer!, modelo: model);

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

  Future creActualizacionUsuario(Usuario user) async{

    this.isSaving = true;
    notifyListeners();

    if(user.idUsuario == null){
        await crearUsuario(user);
    }else{
        await updateUsuario(user);
    }

    this.isSaving = false;
    notifyListeners();

  }  

  Future<String> crearUsuario(Usuario user) async{

    final url = Uri.https(_baseURL, 'usuario.json');
    final response = await http.post(url, body: user.toJson());

    final datos = json.decode(response.body);

    user.idUsuario = datos['name'];

    return "Usuario creado";
  }

  Future<String> updateUsuario(Usuario user) async{

    final url = Uri.https(_baseURL, 'usuario.json');
    final response = await http.put(url, body: user.toJson());

    final datos = json.decode(response.body);

    this.userActual = user;

    return "Dispositivo actualizado";

  }

  //Funciones del ubicación

  Future<void> obtenerUbicacion() async{
        this.isLoading = true;
        notifyListeners();

        final url = Uri.https(_baseURL, 'ubicacion.json');
        final response = await http.get(url);
        final Map<String, dynamic> mapDisp = json.decode(response.body);
        this.ubiActual = Ubicacion(idDispositivo: "Nulo", latitud: 0, longitud: 0);

        mapDisp.forEach((key, value) {
          if(value['idDispositivo'] == this.dispActual.idDispositivo){
            final tempUbi = Ubicacion.fromMap(value);
            tempUbi.idUbicacion = key;
            this.ubiActual = tempUbi;
          }
        });

        this.isLoading = false;
        notifyListeners();
    }

    Future creActualizacionUbi(Ubicacion ubi) async{

    this.isSaving = true;
    notifyListeners();

    if(ubi.idUbicacion == null){
        await crearUbicacion(ubi);
    }else{
        await updateUbicacion(ubi);
    }

    this.isSaving = false;
    notifyListeners();

  }  

  Future<String> crearUbicacion(Ubicacion ubi) async{

    final url = Uri.https(_baseURL, 'ubicacion.json');
    final response = await http.post(url, body: ubi.toJson());

    final datos = json.decode(response.body);

    ubi.idUbicacion = datos['name'];

    return "Usuario creado";
  }

  Future<String> updateUbicacion(Ubicacion ubi) async{

    final url = Uri.https(_baseURL, 'ubicacion.json');
    final response = await http.put(url, body: ubi.toJson());

    final datos = json.decode(response.body);

    this.ubiActual = ubi;

    return "Dispositivo actualizado";

  }

}

