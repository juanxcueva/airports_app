import 'package:aeropuertos_big_data/app/domain/models/RetrasosSalida.dart';
import 'package:aeropuertos_big_data/app/domain/repository/route_repository.dart';
import 'package:aeropuertos_big_data/app/domain/responses/AirportRouteLlegadaResponse.dart';
import 'package:aeropuertos_big_data/app/domain/responses/AirportRouteResponse.dart';
import 'package:aeropuertos_big_data/app/ui/pages/splash/splash_page.dart';
import 'package:aeropuertos_big_data/app/ui/theme/styles.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class DelayRoutesController extends SimpleNotifier {
  final _routeRepository = Get.i.find<RouteRepository>();

  DelayRoutesController() {
    init();
  }
  //variables
  int _currentIndex = 0;
  List<String> _columns = ['Origen', 'Destino', 'Retrasos'];
  List<RetrasosSalida> _retrasos = [];
  int? _sortColumnIndex;
  bool _isAscending = false;

  String _retrasosTot = "";
  String _rutaMas = "";
  List<RetrasosSalida> _top5 = [];
  bool _disposed = false;

  //Gets
  int get currentIndex => _currentIndex;
  int? get sortColumnIndex => _sortColumnIndex;
  bool get isAscending => _isAscending;
  String get rutaMas => _rutaMas;
  String get retrasosTot => _retrasosTot;

  List<String> get columns => _columns;
  List<RetrasosSalida> get retrasos => _retrasos;
  List<RetrasosSalida> get top5 => _top5;

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

  set retrasos(List<RetrasosSalida> value) {
    _retrasos = value;
    notify(['filas']);
  }

  set top5(List<RetrasosSalida> value) {
    _top5 = value;
    notify(['retrasosTOP']);
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

  List<DataRow> getRows(List<RetrasosSalida> retrasos) =>
      retrasos.map((RetrasosSalida retraso) {
        final cells = [retraso.origen, retraso.destino, retraso.retrasosSalida];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Container(
          width: 95,
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
          '${airport1.retrasosSalida}', '${airport2.retrasosSalida}'));
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
              Text('Retrasos Salida'),
              Text('Retrasos Entrada'),
            ],
            onTap: (index) async {
              if (index == 0) {
                Map<String, dynamic> response =
                    await _routeRepository.getRoutes(tipo: 'salida');
                if (response['error'] != null) {
                  Map<String, dynamic> map = {
                    "estado": -1,
                    "msg": response['error']
                  };
                } else {
                  print("llego aqui a pedir");
                  // print(response['data']);
                  AirportRouteResponse respuesta =
                      AirportRouteResponse.fromMap(response['data']);
                  print(respuesta.toMap());
                  getData(respuesta);
                }
              } else {
                Map<String, dynamic> response =
                    await _routeRepository.getRoutes(tipo: 'llegada');
                if (response['error'] != null) {
                  Map<String, dynamic> map = {
                    "estado": -1,
                    "msg": response['error']
                  };
                } else {
                  print("llego aqui a pedir");
                  // print(response['data']);
                  AirportRouteLlegadaResponse respuesta =
                      AirportRouteLlegadaResponse.fromMap(response['data']);
                  print(respuesta.toMap());
                  routesProvider.read.getDataLlegada(respuesta);
                }
              }
              print(index);
            },
          ),
        ),
      ),
    );
  }

  void getData(AirportRouteResponse respuesta) {
    if (respuesta.totalRetrasos.toString() != "0") {
      print("entro a setear");
      _retrasosTot = respuesta.totalRetrasos.toString();
      _rutaMas =
          "${respuesta.retrasos![0].origen}-${respuesta.retrasos![0].destino}";
      _retrasos = respuesta.retrasos!;
      _top5=[];
      for (var i = 0; i < 5; i++) {
        _top5.add(RetrasosSalida(
            origen: _retrasos[i].origen.substring(0, 3),
            destino: _retrasos[i].destino.substring(0, 3),
            retrasosSalida: _retrasos[i].retrasosSalida));
            
      }
    }
    notify(['rutaMas', 'retrasosTot', 'filas', 'retrasosTOP']);
    notify();
  }

  void getDataLlegada(AirportRouteLlegadaResponse respuesta) {
    // dispose();
    if (respuesta.totalRetrasos.toString() != "0") {
      _retrasosTot = respuesta.totalRetrasos.toString();
      _rutaMas =
          "${respuesta.retrasos![0].origen}-${respuesta.retrasos![0].destino}";
      _retrasos = respuesta.retrasos!;
      _top5=[];
      for (var i = 0; i < 5; i++) {
        _top5.add(RetrasosSalida(
            origen: _retrasos[i].origen.substring(0, 3),
            destino: _retrasos[i].destino.substring(0, 3),
            retrasosSalida: _retrasos[i].retrasosSalida));
      }
    }

    notify(['rutaMas', 'retrasosTot', 'filas', 'retrasosTOP']);
    notify();
  }

  Future<void> init() async {
    // _retrasos = allRetrasos;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notify();
    }
  }

  // @override
  // void dispose() {
  //   // YOUR CODE HERE
  //   super.dispose(); // <-- you must call to the super method
  // }
}
