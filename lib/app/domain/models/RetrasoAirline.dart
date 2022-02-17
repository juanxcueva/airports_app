import 'dart:convert';

class RetrasoAirline {
  RetrasoAirline({
    required this.aerolinea,
    required this.retrasosSalida,
  });

  String aerolinea;
  int retrasosSalida;

  factory RetrasoAirline.fromJson(String str) =>
      RetrasoAirline.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RetrasoAirline.fromMap(Map<String, dynamic> json) => RetrasoAirline(
        aerolinea: json["aerolinea"],
        retrasosSalida: json["retrasos_salida"] ?? json["retrasos_llegada"],
      );

  Map<String, dynamic> toMap() => {
        "aerolinea": aerolinea,
        "retrasos_salida": retrasosSalida,
      };
}
