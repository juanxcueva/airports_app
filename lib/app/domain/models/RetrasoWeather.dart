import 'dart:convert';

class RetrasoWeather {
  RetrasoWeather({
    required this.origen,
    required this.destino,
    required this.aerolinea,
    required this.retrasosAerolinea,
    required this.retrasosClima,
  });

  String origen;
  String destino;
  String aerolinea;
  int retrasosAerolinea;
  int retrasosClima;

  factory RetrasoWeather.fromJson(String str) =>
      RetrasoWeather.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RetrasoWeather.fromMap(Map<String, dynamic> json) => RetrasoWeather(
        origen: json["origen"],
        destino: json["destino"],
        aerolinea: json["aerolinea"],
        retrasosAerolinea: json["retrasos_aerolinea"],
        retrasosClima: json["retrasos_clima"],
      );

  Map<String, dynamic> toMap() => {
        "origen": origen,
        "destino": destino,
        "aerolinea": aerolinea,
        "retrasos_aerolinea": retrasosAerolinea,
        "retrasos_clima": retrasosClima,
      };
}
