import 'dart:convert';

class RetrasosSalida {
    RetrasosSalida({
        required this.origen,
        required this.destino,
        required this.retrasosSalida,
    });

    String origen;
    String destino;
    int retrasosSalida;

    factory RetrasosSalida.fromJson(String str) => RetrasosSalida.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RetrasosSalida.fromMap(Map<String, dynamic> json) => RetrasosSalida(
        origen: json["origen"],
        destino: json["destino"],
        retrasosSalida: json["retrasos_salida"] ?? json["retrasos_llegada"],
    );

    Map<String, dynamic> toMap() => {
        "origen": origen,
        "destino": destino,
        "retrasos_salida": retrasosSalida,
    };
}


final allRetrasos = <RetrasosSalida>[
  RetrasosSalida(origen: 'Tampa International', destino: 'Long Island - MacArthur"', retrasosSalida: 378),
  RetrasosSalida(origen: 'Chicago Midway', destino: 'Gen Edw L Logan Intl', retrasosSalida: 324),
  RetrasosSalida(origen: 'Charlotte/Douglas International', destino: 'Palm Beach International"', retrasosSalida: 1019),
  RetrasosSalida(origen: 'Albuquerque International', destino: 'Los Angeles International', retrasosSalida: 935),
  RetrasosSalida(origen: 'Denver Intl', destino: 'Tulsa International', retrasosSalida: 551),
  RetrasosSalida(origen: 'John Wayne /Orange Co', destino: 'Chicago O Hare International', retrasosSalida: 883),
  RetrasosSalida(origen: 'Salt Lake City Intl', destino: 'Durango-La Plata County', retrasosSalida: 130),
  RetrasosSalida(origen: 'Luis Munoz Marin International', destino: 'Baltimore-Washington International', retrasosSalida: 118),
  RetrasosSalida(origen: 'Salt Lake City Intl', destino: 'New Orleans International', retrasosSalida: 144),
  RetrasosSalida(origen: 'Southwest Florida International', destino: 'Ronald Reagan Washington National', retrasosSalida: 218),
  RetrasosSalida(origen: 'Jacksonville International', destino: 'Austin-Bergstrom International', retrasosSalida: 66),

];