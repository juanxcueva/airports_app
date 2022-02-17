import 'package:aeropuertos_big_data/app/domain/repository/route_repository.dart';
import 'package:aeropuertos_big_data/app/domain/responses/AirportRouteResponse.dart';
import 'package:aeropuertos_big_data/app/ui/pages/splash/splash_page.dart';
import 'package:aeropuertos_big_data/app/ui/routes/routes.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SplashController extends SimpleNotifier {
  final _routeRepository = Get.i.find<RouteRepository>();

  String route = "";
  SplashController() {
    _init();
  }

  String text = 'Cargando';
  bool navigate = false;
  void _init() async {
    await await Future.delayed(const Duration(milliseconds: 500));
    text = text + ".";
    notify();

    Map<String, dynamic> response =
        await _routeRepository.getRoutes(tipo: 'salida');

    await Future.delayed(const Duration(milliseconds: 500));
    text = text + ".";
    notify();
    await Future.delayed(const Duration(milliseconds: 500));
    text = text + ".";
    await Future.delayed(const Duration(milliseconds: 200));
    if (response['error'] != null) {
      Map<String, dynamic> map = {"estado": -1, "msg": response['error']};
    } else {
      print("llego aqui a pedir");
      // print(response['data']);
      AirportRouteResponse respuesta =
          AirportRouteResponse.fromMap(response['data']);
      print(respuesta.toMap());
      routesProvider.read.getData(respuesta);
      route = Routes.bottomBar;
      navigate = true;
    }
    notify();
  }
}
