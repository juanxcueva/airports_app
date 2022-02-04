import 'package:aeropuertos_big_data/app/ui/pages/bottom_bar/bottom_nav_bar_page.dart';
import 'package:aeropuertos_big_data/app/ui/pages/delays_airlines/delays_airlines_page.dart';
import 'package:aeropuertos_big_data/app/ui/pages/delays_routes/delay_routes_page.dart';
import 'package:aeropuertos_big_data/app/ui/pages/delays_weather/delay_weather_page.dart';
import 'package:aeropuertos_big_data/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Routes.routes: (_) => const DelayRoutesPage(),
  Routes.weather: (_) => const DelayWeatherPage(),
  Routes.airlines: (_) => const DelayAirlinesPage(),
  Routes.bottomBar: (_) => const BottomNavBarPage(),

};
