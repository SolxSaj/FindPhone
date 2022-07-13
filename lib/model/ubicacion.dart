import 'dart:convert';

class Ubicacion {
    Ubicacion({
        this.idUbicacion,
        required this.idDispositivo,
        required this.latitud,
        required this.longitud,
    });

    String? idUbicacion;
    String idDispositivo;
    double latitud;
    double longitud;

    factory Ubicacion.fromJson(String str) => Ubicacion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ubicacion.fromMap(Map<String, dynamic> json) => Ubicacion(
        idDispositivo: json["idDispositivo"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "idDispositivo": idDispositivo,
        "latitud": latitud,
        "longitud": longitud,
    };

    Ubicacion copy() => Ubicacion(
      idUbicacion: this.idUbicacion,
      idDispositivo: this.idDispositivo,
      latitud: this.latitud,
      longitud: this.longitud
    );
}