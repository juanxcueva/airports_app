import 'package:aeropuertos_big_data/app/ui/pages/delays_routes/controller/delay_routes_controller.dart';
import 'package:aeropuertos_big_data/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'controller/splash_controller.dart';

final splashProvider = SimpleProvider(
  (ref) {

    return SplashController();
  },
);

final routesProvider = SimpleProvider(
  (ref) => DelayRoutesController(),
  autoDispose: false,
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      provider: splashProvider,
      onChange: (context, controller) {
        if (controller.navigate) {
          Navigator.pushReplacementNamed(context, splashProvider.read.route);
        }
      },
      builder: (_, controller) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * .33,
              ),
              Consumer(
                builder: (_, ref, __) {
                  final splashController = ref.watch(splashProvider);
                  return Text(
                    splashController.text,
                    style: Theme.of(context).textTheme.overline!.copyWith(
                      color: Colors.white
                    ),
                  );
                },
              )
            ],
          )),
        );
      },
    );
  }
}
