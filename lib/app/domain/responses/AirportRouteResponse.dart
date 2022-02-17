// To parse this JSON data, do
//
//     final airportRouteResponse = airportRouteResponseFromMap(jsonString);

import 'dart:convert';

import 'package:aeropuertos_big_data/app/domain/models/RetrasosSalida.dart';

class AirportRouteResponse {
    AirportRouteResponse({
        this.ok,
        this.totalRegistros,
        this.totalRetrasos,
        this.retrasos,
    });

    bool? ok;
    int? totalRegistros;
    int? totalRetrasos;
    List<RetrasosSalida>? retrasos;

    factory AirportRouteResponse.fromJson(String str) => AirportRouteResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AirportRouteResponse.fromMap(Map<String, dynamic> json) => AirportRouteResponse(
        ok: json["ok"],
        totalRegistros: json["total_registros"],
        totalRetrasos: json["total_retrasos"],
        retrasos: List<RetrasosSalida>.from(json["retrasos"].map((x) => RetrasosSalida.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "total_registros": totalRegistros,
        "total_retrasos": totalRetrasos,
        "retrasos": List<dynamic>.from(retrasos!.map((x) => x.toMap())),
    };
}


