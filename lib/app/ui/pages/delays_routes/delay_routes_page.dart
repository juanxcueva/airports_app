import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/bar_chart.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/custom_app_bar.dart';
import 'package:aeropuertos_big_data/app/ui/widgets/stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'controller/delay_routes_controller.dart';

final bottomNavBarProvider = SimpleProvider(
  (ref) => DelayRoutesController(),
);

class DelayRoutesPage extends StatelessWidget {
  const DelayRoutesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          bottomNavBarProvider.read.buildHeader(),
          bottomNavBarProvider.read.buildRegionTabBar(),
          bottomNavBarProvider.read.buildStatsTabBar(),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: BarChartSample3(),
            ),
          ),
        ],
      ),
    );
  }
}
