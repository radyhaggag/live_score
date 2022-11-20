import 'package:flutter/material.dart';

import 'config/app_route.dart';
import 'config/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.soccerLayout,
      onGenerateRoute: AppRouter.routesGenerator,
      theme: getAppTheme(),
    );
  }
}
