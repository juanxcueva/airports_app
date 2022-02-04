import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

void injectDependencies() {
  //var's
  final _dio =
      Dio(BaseOptions(baseUrl: 'https://dac7-191-100-27-218.ngrok.io/api/'));
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  Get.i.put<Dio>(_dio);

  // Get.i.lazyPut<DOrderRepository>(() => DOrderRepositoryImpl(DOrderDatabase()));
}
