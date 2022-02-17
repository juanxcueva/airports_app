import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({
    Key? key,
    required this.retrasos,
    required this.ruta,
    required this.titulo1,
    required this.titulo2,
  }) : super(key: key);

  final String retrasos;
  final String ruta;
  final String titulo1;
  final String titulo2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(titulo1, retrasos, Colors.green),
                _buildStatCard(titulo2, ruta, Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildAirlines(BuildContext context) {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.15,
  //     child: Column(
  //       children: <Widget>[
  //         Flexible(
  //           child: Row(
  //             children: <Widget>[
  //               _buildStatCard('Retrasos Totales', '1.81 M', Colors.green),
  //               _buildStatCard('Ruta Con Mas Retrasos', 'Cuenca-Quito', Colors.orange),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //Va aerolineas en el eje x del grafico

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: TextStyle(
                color: Colors.white,
                fontSize: title == "Retrasos Totales" ? 19.0 : 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
