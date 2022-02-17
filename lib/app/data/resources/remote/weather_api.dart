import 'package:aeropuertos_big_data/app/data/resources/local/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class WeatherAPI {
  final _dio = Get.i.find<Dio>();

  Future<Map<String, dynamic>> getWeather(String tipo) async {
    Map<String, dynamic> newResponse;
    try {
      final response = await _dio.get(
        'retrasos-vuelos/$tipo',
        options: Options(
          sendTimeout: 3000,
          receiveTimeout: 5000,
        ),
      );
      newResponse = returnResponse(response);
    } on DioError catch (e) {
      newResponse = returnResponse(e.response);
    }
    return newResponse;
  }
}
