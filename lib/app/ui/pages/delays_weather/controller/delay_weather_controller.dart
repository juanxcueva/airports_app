import 'package:aeropuertos_big_data/app/domain/models/RetrasoWeather.dart';
import 'package:aeropuertos_big_data/app/domain/repository/weather_repository.dart';
import 'package:aeropuertos_big_data/app/domain/responses/AirportWeatherResponse.dart';
import 'package:aeropuertos_big_data/app/ui/theme/styles.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class DelayWeatherController extends SimpleNotifier {
  final _weatherRepository = Get.i.find<WeatherRepository>();

  DelayWeatherController() {
    init();
  }
  //variables
  int _currentIndex = 0;
  List<String> _columns = ['Origen', 'Destino', 'Retrasos'];
  List<RetrasoWeather> _retrasos = [];
  int? _sortColumnIndex;
  bool _isAscending = false;
  bool _isAirline = true;

  String _retrasosTot = "";
  String _rutaMas = "";
  List<RetrasoWeather> _top5 = [];
  bool _disposed = false;
  AirportWeatherResponse respuestaAirline = new AirportWeatherResponse();

  //Gets
  int get currentIndex => _currentIndex;
  int? get sortColumnIndex => _sortColumnIndex;
  bool get isAscending => _isAscending;
  String get rutaMas => _rutaMas;
  String get retrasosTot => _retrasosTot;

  List<String> get columns => _columns;
  List<RetrasoWeather> get retrasos => _retrasos;
  List<RetrasoWeather> get top5 => _top5;
  //set's

  set currentIndex(int value) {
    _currentIndex = value;
    notify(['index']);
  }

  set rutaMas(String value) {
    _rutaMas = value;
    notify(['rutaMas']);
  }

  set retrasosTot(String value) {
    _retrasosTot = value;
    notify(['retrasosTot']);
  }

  set sortColumnIndex(int? value) {
    _sortColumnIndex = value;
    notify(['sortColumn']);
  }

  set isAscending(bool value) {
    _isAscending = value;
    notify(['isAscending']);
  }

  set columns(List<String> value) {
    _columns = value;
    notify(['columns']);
  }

  set retrasos(List<RetrasoWeather> value) {
    _retrasos = value;
    notify(['filas']);
  }

  set top5(List<RetrasoWeather> value) {
    _top5 = value;
    notify(['topRetrasos']);
  }

  //methods
  void onChangeSelectedIndex(int value) {
    _currentIndex = value;
    notify(['index']);
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: TextStyle(color: Colors.white),
            ),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<RetrasoWeather> retrasos) =>
      retrasos.map((RetrasoWeather retraso) {
        final cells = [
          retraso.origen,
          retraso.destino,
          _isAirline ? retraso.retrasosAerolinea : retraso.retrasosClima
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Container(
          width: 90,
          child: Text(
            '$data',
            style: TextStyle(color: Colors.white),
          ))))
      .toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      _retrasos.sort((airport1, airport2) =>
          compareString(ascending, airport1.origen, airport2.origen));
    } else if (columnIndex == 1) {
      _retrasos.sort((airport1, airport2) =>
          compareString(ascending, airport1.destino, airport2.destino));
    } else if (columnIndex == 2) {
      _retrasos.sort((airport1, airport2) => compareString(ascending,
          '${airport1.retrasosAerolinea}', '${airport2.retrasosAerolinea}'));
    }

    sortColumnIndex = columnIndex;
    isAscending = ascending;
    notify(['sortColumn', 'isAscending']);
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  SliverToBoxAdapter buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: const BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: const <Widget>[
              Text('Retrasos Aerolinea'),
              Text('Retrasos Clima'),
            ],
            onTap: (index) async {
              if (index == 0) {
                getData(respuestaAirline);
              } else {
                getDataLlegada(respuestaAirline);
              }
              print(index);
            },
          ),
        ),
      ),
    );
  }

  void getData(AirportWeatherResponse respuesta) {
    _retrasos = respuesta.retrasos!;
    _top5 = [];
    for (var i = 0; i < 5; i++) {
      _top5.add(RetrasoWeather(
        aerolinea: _retrasos[i].aerolinea.substring(0, 3),
        origen: _retrasos[i].origen.substring(0, 3),
        destino: _retrasos[i].destino.substring(0, 3),
        retrasosAerolinea: _retrasos[i].retrasosAerolinea,
        retrasosClima: 0,
      ));
    }
    _isAirline = true;
    notify(['rutaMas', 'retrasosTot', 'filas', 'topRetrasos']);
    notify();
  }

  void getDataLlegada(AirportWeatherResponse respuesta) {
    // dispose();
    _retrasos = respuesta.retrasos!;
    _top5 = [];
    for (var i = 0; i < 5; i++) {
      _top5.add(RetrasoWeather(
        aerolinea: _retrasos[i].aerolinea.substring(0, 3),
        origen: _retrasos[i].origen.substring(0, 3),
        destino: _retrasos[i].destino.substring(0, 3),
        retrasosAerolinea: _retrasos[i].retrasosClima,
        retrasosClima: 0,
      ));
    }
    _isAirline = false;
    notify(['rutaMas', 'retrasosTot', 'filas', 'topRetrasos']);
    notify();
  }

  void init() async {
    Map<String, dynamic> response =
        await _weatherRepository.getWeather(tipo: 'aerolinea-clima');
    if (response['error'] != null) {
      Map<String, dynamic> map = {"estado": -1, "msg": response['error']};
    } else {
      print("llego aqui a pedir");
      // print(response['data']);
      AirportWeatherResponse respuesta =
          AirportWeatherResponse.fromMap(response['data']);
      respuestaAirline = respuesta;
      print(respuesta.toMap());
      getData(respuesta);
    }
  }
}
