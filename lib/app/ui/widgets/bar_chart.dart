import 'package:aeropuertos_big_data/app/domain/models/RetrasosSalida.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  const _BarChart({Key? key, required this.top5}) : super(key: key);

  final List<RetrasosSalida> top5;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: getTitulos(top5), //Esta
        borderData: borderData,
        barGroups: top5[0] != [] ? getbarGroups(top5) : [], //Esta
        alignment: BarChartAlignment.spaceAround,
        maxY: 1.3 * top5[0].retrasosSalida.toDouble(),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData getTitulos(List<RetrasosSalida> top5) {
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        margin: 20,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return '${top5[0].origen}-${top5[0].destino}';
            case 1:
              return '${top5[1].origen}-${top5[1].destino}';
            case 2:
              return '${top5[2].origen}-${top5[2].destino}';
            case 3:
              return '${top5[3].origen}-${top5[3].destino}';
            case 4:
              return '${top5[4].origen}-${top5[4].destino}';
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> getbarGroups(List<RetrasosSalida> top5) {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              y: top5[0].retrasosSalida.toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              y: top5[1].retrasosSalida.toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              y: top5[2].retrasosSalida.toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              y: top5[3].retrasosSalida.toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              y: top5[4].retrasosSalida.toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }
}

class BarChartSample2 extends StatelessWidget {
  const BarChartSample2({Key? key, required this.top5}) : super(key: key);

  final List<RetrasosSalida> top5;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: top5 != []
            ? _BarChart(
                top5: top5,
              )
            : Container(),
      ),
    );
  }
}

// class BarChartSample3 extends StatefulWidget {
//   const BarChartSample3({
//     Key? key,
//     required this.top5,
//   }) : super(key: key);

//   final List<RetrasosSalida> top5;

//   @override
//   State<StatefulWidget> createState() => BarChartSample3State();
// }

// class BarChartSample3State extends State<BarChartSample3> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.7,
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//         color: const Color(0xff2c4260),
//         child: _BarChart(
//           top5: top5,
//         ),
//       ),
//     );
//   }
// }
