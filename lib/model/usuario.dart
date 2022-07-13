import 'dart:convert';

import 'package:findphone_vdos/model/dispositivo.dart';

class Usuario {
    Usuario({
        this.idUsuario,
        required this.apellido,
        required this.email,
        required this.nombre,
        required this.password,
    });

    String? idUsuario;
    String apellido;
    String email;
    String nombre;
    String password;

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        apellido: json["apellido"],
        email: json["email"],
        nombre: json["nombre"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "apellido": apellido,
        "email": email,
        "nombre": nombre,
        "password": password,
    };

    Usuario copy() => Usuario(
      idUsuario: this.idUsuario,
      nombre: this.nombre,
      apellido: this.apellido,
      email: this.email,
      password: this.password
    );
}
