import 'dart:io';

import 'package:aeropuertos_big_data/app/data/resources/remote/airline_api.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'app/data/repository_impl/airline_repository_impl.dart';
import 'app/data/repository_impl/route_repository_impl.dart';
import 'app/data/repository_impl/weather_repository_impl.dart';
import 'app/data/resources/remote/route_api.dart';
import 'app/data/resources/remote/weather_api.dart';
import 'app/domain/repository/airline_repository.dart';
import 'app/domain/repository/route_repository.dart';
import 'app/domain/repository/weather_repository.dart';

void injectDependencies() {
  //var's
  final _dio =
      Dio(BaseOptions(baseUrl: 'https://9df1-186-43-227-102.ngrok.io/api/'));
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  Get.i.put<Dio>(_dio);

  Get.i.lazyPut<AirlineRepository>(() => AirlineRepositoryImpl(AirlineAPI()));
  Get.i.lazyPut<RouteRepository>(() => RouteRepositoryImpl(RouteAPI()));
  Get.i.lazyPut<WeatherRepository>(() => WeatherRepositoryImpl(WeatherAPI()));

}
