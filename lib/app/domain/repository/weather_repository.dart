
abstract class WeatherRepository {
  Future<Map<String, dynamic>> getWeather({required String tipo});
}
