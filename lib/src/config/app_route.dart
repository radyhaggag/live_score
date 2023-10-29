import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../container_injector.dart';
import '../core/domain/entities/soccer_fixture.dart';
import '../core/utils/app_strings.dart';
import '../features/fixture/domain/use_cases/events_usecase.dart';
import '../features/fixture/domain/use_cases/lineups_usecase.dart';
import '../features/fixture/domain/use_cases/statistics_usecase.dart';
import '../features/fixture/presentation/cubit/fixture_cubit.dart';
import '../features/fixture/presentation/screens/fixture_screen.dart';
import '../features/soccer/presentation/cubit/soccer_cubit.dart';
import '../features/soccer/presentation/screens/fixtures_screen.dart';
import '../features/soccer/presentation/screens/soccer_layout.dart';
import '../features/soccer/presentation/screens/soccer_screen.dart';
import '../features/soccer/presentation/screens/standings_screen.dart';

class Routes {
  static const String soccerLayout = "soccerLayout";
  static const String soccer = "soccer";
  static const String fixtures = "fixtures";
  static const String standings = "standings";
  static const String fixture = "fixture";
}

class AppRouter {
  static Route routesGenerator(RouteSettings settings) {
    switch (settings.name) {
      case Routes.soccerLayout:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SoccerCubit>(),
            child: const SoccerLayout(),
          ),
        );
      case Routes.soccer:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: sl<SoccerCubit>(),
            child: const SoccerScreen(),
          ),
        );
      case Routes.fixtures:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: sl<SoccerCubit>(),
            child: const FixturesScreen(),
          ),
        );
      case Routes.fixture:
        return MaterialPageRoute(
          builder: (context) {
            SoccerFixture soccerFixture = settings.arguments as SoccerFixture;
            return BlocProvider(
              create: (context) => FixtureCubit(
                lineupsUseCase: sl<LineupsUseCase>(),
                eventsUseCase: sl<EventsUseCase>(),
                statisticsUseCase: sl<StatisticsUseCase>(),
              )..getLineups(soccerFixture.fixture.id.toString()),
              child: FixtureScreen(soccerFixture: soccerFixture),
            );
          },
        );
      case Routes.standings:
        return MaterialPageRoute(builder: (context) => const StandingsScreen());
    }
    return MaterialPageRoute(builder: (context) => const NoRouteFound());
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text(AppStrings.noRouteFound)),
      );
}
