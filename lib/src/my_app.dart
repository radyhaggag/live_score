import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_route.dart';
import 'config/app_theme.dart';
import 'core/utils/app_strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.soccerLayout,
        onGenerateRoute: AppRouter.routesGenerator,
        title: AppStrings.appName,
        theme: getAppTheme(),
      ),
    );
  }
}
