import 'dart:convert';

import 'package:aeropuertos_big_data/app/domain/models/RetrasoAirline.dart';

class AirportAirlinesResponse {
  AirportAirlinesResponse({
    this.ok,
    this.totalRegistros,
    this.totalRetrasos,
    this.retrasos,
  });

  bool? ok;
  int? totalRegistros;
  int? totalRetrasos;
  List<RetrasoAirline>? retrasos;

  factory AirportAirlinesResponse.fromJson(String str) =>
      AirportAirlinesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AirportAirlinesResponse.fromMap(Map<String, dynamic> json) =>
      AirportAirlinesResponse(
        ok: json["ok"],
        totalRegistros: json["total_registros"],
        totalRetrasos: json["total_retrasos"],
        retrasos:
            List<RetrasoAirline>.from(json["retrasos"].map((x) => RetrasoAirline.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "total_registros": totalRegistros,
        "total_retrasos": totalRetrasos,
        "retrasos": List<dynamic>.from(retrasos!.map((x) => x.toMap())),
      };
}


