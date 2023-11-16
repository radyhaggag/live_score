import 'package:flutter/material.dart';

import 'config/app_route.dart';
import 'config/app_theme.dart';
import 'core/utils/app_strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.soccerLayout,
      onGenerateRoute: AppRouter.routesGenerator,
      title: AppStrings.appName,
      theme: getAppTheme(),
    );
  }
}
