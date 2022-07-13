// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class Dispositivo {
    Dispositivo({
        this.idDispositivo,
        required this.idUsuario,
        required this.imei,
        required this.marca,
        required this.modelo,
    });

    String? idDispositivo;
    String idUsuario;
    String imei;
    String marca;
    String modelo;

    factory Dispositivo.fromJson(String str) => Dispositivo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dispositivo.fromMap(Map<String, dynamic> json) => Dispositivo(
        idUsuario: json["idUsuario"],
        imei: json["imei"],
        marca: json["marca"],
        modelo: json["modelo"],
    );

    Map<String, dynamic> toMap() => {
        "idUsuario": idUsuario,
        "imei": imei,
        "marca": marca,
        "modelo": modelo,
    };

    Dispositivo copy() => Dispositivo(
      idDispositivo: this.idDispositivo,
      idUsuario: this.idUsuario,
      imei: this.imei,
      marca: this.marca,
      modelo: this.modelo
    );
    
}
