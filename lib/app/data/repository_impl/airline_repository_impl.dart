

import 'package:aeropuertos_big_data/app/data/resources/remote/airline_api.dart';
import 'package:aeropuertos_big_data/app/domain/repository/airline_repository.dart';

class AirlineRepositoryImpl extends AirlineRepository {
  final AirlineAPI _api;
  AirlineRepositoryImpl(this._api);

  @override
  Future<Map<String, dynamic>> getAirlines({required String tipo}) =>_api.getAirlines(tipo);

  
}
