import 'package:aeropuertos_big_data/app/ui/pages/delays_weather/controller/delay_weather_controller.dart';
import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/bar_chart_weather.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/build_header.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final weatherProvider = SimpleProvider(
  (ref) => DelayWeatherController(),
);

class DelayWeatherPage extends StatelessWidget {
  const DelayWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        color: AppColors.secondaryColor,
      ),
      backgroundColor: AppColors.secondaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          buildHeader('Retrasos Por Condición Climatica'),
          weatherProvider.read.buildRegionTabBar(),
          // weatherProvider.read.buildStatsTabBar(),

          buildHeader('Top 5 Aereolineas Con Mas Retrasos'),
          Consumer(builder: (_, ref, __) {
            final top5 =
                ref.watch(weatherProvider.ids(() => ['retrasosTOP'])).top5;
            return SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: top5.length > 0
                    ? BarChartSample2(
                        top5: top5,
                      )
                    : Container(),
              ),
            );
          }),
         
          buildHeader('Retrasos'),
          Consumer(builder: (_, ref, __) {
            final sortColumnIndex = ref
                .watch(weatherProvider.ids(() => ['sortColumn']))
                .sortColumnIndex;
            final isAscending = ref
                .watch(weatherProvider.ids(() => ['isAscending']))
                .isAscending;

            return SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff2c4260),
                  ),
                  width: double.infinity,
                  child: DataTable(
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: isAscending,
                    columns: weatherProvider.read
                        .getColumns(weatherProvider.read.columns),
                    rows: weatherProvider.read
                        .getRows(weatherProvider.read.retrasos),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
