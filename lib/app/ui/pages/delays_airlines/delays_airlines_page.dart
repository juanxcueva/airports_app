import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/build_header.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/custom_app_bar.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/pie_chart_weather.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'controller/delays_airlines_controller.dart';

final airlinesProvider = SimpleProvider(
  (ref) => DelayAirlinesController(),
);

class DelayAirlinesPage extends StatelessWidget {
  const DelayAirlinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        color: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          buildHeader('Retrasos Por Aerolineas'),
          airlinesProvider.read.buildRegionTabBar(),

          Consumer(builder: (_, ref, __) {
            final rutaMas =
                ref.watch(airlinesProvider.ids(() => ['rutaMas'])).rutaMas;
            final retrasosTot = ref
                .watch(airlinesProvider.ids(() => ['retrasosTot']))
                .retrasosTot;
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: StatsGrid(
                  retrasos: retrasosTot,
                  ruta: rutaMas, titulo1: 'Aerolines con retrasos', titulo2: 'Aerolineas Con Mas Retrasos',
                ),
              ),
            );
          }),

          buildHeader('Top 4 Aerolineas Con Mas Retrasos'),
          Consumer(builder: (_, ref, __) {
            final top5 =
                ref.watch(airlinesProvider.ids(() => ['topRetrasos'])).top5;
            return SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: top5.length > 0
                    ? PieChartSample3(
                        top5: top5,
                      )
                    : Container(),
              ),
            );
          }),

          buildHeader('Retrasos'),
          Consumer(builder: (_, ref, __) {
            final sortColumnIndex = ref
                .watch(airlinesProvider.ids(() => ['sortColumn']))
                .sortColumnIndex;
            final isAscending = ref
                .watch(airlinesProvider.ids(() => ['isAscending']))
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
                    columns: airlinesProvider.read
                        .getColumns(airlinesProvider.read.columns),
                    rows: airlinesProvider.read
                        .getRows(airlinesProvider.read.retrasos),
                  ),
                ),
              ),
            );
          }),

          // SliverPadding(
          //   padding: const EdgeInsets.only(top: 20.0),
          //   sliver: SliverToBoxAdapter(
          //     child: BarChartSample3(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
