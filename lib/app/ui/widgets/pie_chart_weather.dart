import 'package:aeropuertos_big_data/app/domain/models/RetrasoAirline.dart';
import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';

class PieChartSample3 extends StatelessWidget {
  const PieChartSample3({Key? key, required this.top5}) : super(key: key);
  final List<RetrasoAirline> top5;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: AppColors.secondaryColor,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(top5)),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: top5[0].aerolinea,
                  isSquare: true,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: top5[1].aerolinea,
                  isSquare: true,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfffa5f49),
                  text: top5[2].aerolinea,
                  isSquare: true,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: top5[3].aerolinea,
                  isSquare: true,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections(List<RetrasoAirline> top5) {
  return List.generate(4, (i) {
    final fontSize = 16.0;
    final radius = 50.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 25,
          title: '${top5[0].retrasosSalida}',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: 25,
          title: '${top5[1].retrasosSalida}',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xfffa5f49),
          value: 25,
          title: '${top5[2].retrasosSalida}',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xff13d38e),
          value: 25,
          title: '${top5[3].retrasosSalida}',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        throw Error();
    }
  });
}
