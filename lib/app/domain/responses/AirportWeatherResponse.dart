import 'dart:convert';

import 'package:aeropuertos_big_data/app/domain/models/RetrasoWeather.dart';

class AirportWeatherResponse {
  AirportWeatherResponse({
    this.ok,
    this.retrasos,
  });

  bool? ok;
  List<RetrasoWeather>? retrasos;

  factory AirportWeatherResponse.fromJson(String str) =>
      AirportWeatherResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AirportWeatherResponse.fromMap(Map<String, dynamic> json) =>
      AirportWeatherResponse(
        ok: json["ok"],
        retrasos:
            List<RetrasoWeather>.from(json["retrasos"].map((x) => RetrasoWeather.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "retrasos": List<dynamic>.from(retrasos!.map((x) => x.toMap())),
      };
}

