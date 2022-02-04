import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'controller/bottom_nav_bar_controller.dart';

final bottomNavBarProvider = SimpleProvider(
  (ref) => BottomNavBarPageController(),
);

class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (_, ref, __) {
        final currentIndex =
            ref.watch(bottomNavBarProvider.ids(() => ['index'])).currentIndex;
        return screens[currentIndex];
      }),
      bottomNavigationBar: Consumer(builder: (_, ref, __) {
        final currentIndex =
            ref.watch(bottomNavBarProvider.ids(() => ['index'])).currentIndex;
        return BottomNavigationBar(
          items: [
            Icons.room_outlined,
            Icons.airplanemode_on_outlined,
            Icons.ac_unit_outlined
          ]
              .asMap()
              .map((key, value) => MapEntry(
                    key,
                    BottomNavigationBarItem(
                      label: '',
                      icon: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: currentIndex == key
                              ? Colors.blue[600]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Icon(value),
                      ),
                    ),
                  ))
              .values
              .toList(),
          currentIndex: currentIndex,
          onTap: (index) {
            bottomNavBarProvider.read.onChangeSelectedIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.color3,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 0.0,
        );
      }),
    );
  }
}
