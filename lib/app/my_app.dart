import 'package:aeropuertos_big_data/app/ui/routes/app_routes.dart';
import 'package:aeropuertos_big_data/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Airport_App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: Routes.bottomBar,
        routes: routes,
        navigatorObservers: [
          router.observer,
        ]);
  }
}
