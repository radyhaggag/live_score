import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';
import 'package:live_score/shared/network/dio_helper.dart';

import 'bloc_observer.dart';
import 'layout/home_layout.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
      DioHelper.init();
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LiveScoreCubit()
        ..getLeagues()
        ..getFixtures(DateFormat("y-MM-dd").format(DateTime.now()).toString()),
      child: BlocConsumer<LiveScoreCubit, LiveScoreStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xFFFAFAFA),
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: Color(0xFFFAFAFA),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              scaffoldBackgroundColor: const Color(0xFFFAFAFA),
            ),
            home: const HomeLayout(),
          );
        },
      ),
    );
  }
}
