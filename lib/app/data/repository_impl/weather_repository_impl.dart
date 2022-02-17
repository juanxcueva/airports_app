
import 'package:aeropuertos_big_data/app/data/resources/remote/weather_api.dart';
import 'package:aeropuertos_big_data/app/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherAPI _api;
  WeatherRepositoryImpl(this._api);

  @override
  Future<Map<String, dynamic>> getWeather({required String tipo})=>_api.getWeather(tipo);


}
