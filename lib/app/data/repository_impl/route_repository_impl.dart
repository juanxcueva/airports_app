
import 'package:aeropuertos_big_data/app/data/resources/remote/route_api.dart';
import 'package:aeropuertos_big_data/app/domain/repository/route_repository.dart';

class RouteRepositoryImpl extends RouteRepository {
  final RouteAPI _api;
  RouteRepositoryImpl(this._api);

  @override
  Future<Map<String, dynamic>> getRoutes({required String tipo}) =>_api.getRoutes(tipo);



}
