import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'container_injector.dart';
import 'config/app_route.dart';
import 'config/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SettingsCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
          selector: (state) => state.themeMode,
          builder: (context, themeMode) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              title: AppStrings.appName,
              theme: getLightAppTheme(),
              darkTheme: getDarkAppTheme(),
              themeMode: themeMode,
            );
          },
        ),
      ),
    );
  }
}
