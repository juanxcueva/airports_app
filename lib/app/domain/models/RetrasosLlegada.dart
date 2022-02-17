import 'dart:convert';

class RetrasosLlegada {
    RetrasosLlegada({
        required this.origen,
        required this.destino,
        required this.retrasosSalida,
    });

    String origen;
    String destino;
    int retrasosSalida;

    factory RetrasosLlegada.fromJson(String str) => RetrasosLlegada.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RetrasosLlegada.fromMap(Map<String, dynamic> json) => RetrasosLlegada(
        origen: json["origen"],
        destino: json["destino"],
        retrasosSalida: json["retrasos_llegada"],
    );

    Map<String, dynamic> toMap() => {
        "origen": origen,
        "destino": destino,
        "retrasos_llegada": retrasosSalida,
    };
}