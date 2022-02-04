import 'package:aeropuertos_big_data/app/ui/pages/delays_airlines/delays_airlines_page.dart';
import 'package:aeropuertos_big_data/app/ui/pages/delays_routes/delay_routes_page.dart';
import 'package:aeropuertos_big_data/app/ui/pages/delays_weather/delay_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class BottomNavBarPageController extends SimpleNotifier {
  // DelayRoutesController() {
  //   init();
  // }
  //variables
  int _currentIndex = 0;

  //Gets
  int get currentIndex => _currentIndex;
  //set's

  set currentIndex(int value) {
    _currentIndex = value;
    notify(['index']);
  }



  //methods
  void onChangeSelectedIndex(int value) {
    _currentIndex = value;
    notify(['index']);
  }

  // Future<void> init() async {

  // }
}

 List<Widget> screens = const [
  DelayRoutesPage(),
  DelayAirlinesPage(),
  DelayWeatherPage(),
];