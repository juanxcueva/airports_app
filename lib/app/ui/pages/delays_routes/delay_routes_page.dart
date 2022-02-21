import 'package:aeropuertos_big_data/app/ui/pages/splash/splash_page.dart';
import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/bar_chart.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/build_header.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/custom_app_bar.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class DelayRoutesPage extends StatelessWidget {
  const DelayRoutesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        color: AppColors.thirdColor,
      ),
      backgroundColor: AppColors.thirdColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          buildHeader('Retrasos Por Ruta'),
          routesProvider.read.buildRegionTabBar(),
          Consumer(builder: (_, ref, __) {
            final rutaMas =
                ref.watch(routesProvider.ids(() => ['rutaMas'])).rutaMas;
            final retrasosTot = ref
                .watch(routesProvider.ids(() => ['retrasosTot']))
                .retrasosTot;
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: StatsGrid(
                  retrasos: retrasosTot,
                  ruta: rutaMas, titulo1: 'Rutas con retrasos', titulo2: 'Ruta Con Mas Retrasos',
                ),
              ),
            );
          }),

          buildHeader('Top 5 Rutas Con Mas Retrasos'),
          Consumer(builder: (_, ref, __) {
            final top5 =
                ref.watch(routesProvider.ids(() => ['retrasosTOP'])).top5;
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
                .watch(routesProvider.ids(() => ['sortColumn']))
                .sortColumnIndex;
            final isAscending = ref
                .watch(routesProvider.ids(() => ['isAscending']))
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
                    columns: routesProvider.read
                        .getColumns(routesProvider.read.columns),
                    rows: routesProvider.read
                        .getRows(routesProvider.read.retrasos),
                  ),
                ),
              ),
            );
          }),

          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.15,
          // ),
        ],
      ),
    );
  }
}
