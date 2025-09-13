import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/features/fixture/presentation/cubit/fixture_cubit.dart';

import '../container_injector.dart';
import '../core/domain/entities/soccer_fixture.dart';
import '../core/utils/app_strings.dart';
import '../features/fixture/presentation/screens/fixture_screen.dart';
import '../features/soccer/presentation/cubit/soccer_cubit.dart';
import '../features/soccer/presentation/screens/fixtures_screen.dart';
import '../features/soccer/presentation/screens/soccer_layout.dart';
import '../features/soccer/presentation/screens/soccer_screen.dart';
import '../features/soccer/presentation/screens/standings_screen.dart';

class Routes {
  static const String soccer = '/soccer';
  static const String fixtures = '/fixtures';
  static const String standings = '/standings';
  static const String fixtureDetails = '/fixture_details';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.soccer,
    routes: [
      ShellRoute(
        builder: (_, _, child) {
          return BlocProvider(
            create: (context) => sl<SoccerCubit>()..getLeagues(),
            child: SoccerLayout(child: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.soccer,
            pageBuilder: (context, _) {
              return const NoTransitionPage(child: SoccerScreen());
            },
          ),
          GoRoute(
            path: Routes.fixtures,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: FixturesScreen(competitionId: state.extra as int?),
              );
            },
          ),
          GoRoute(
            path: Routes.standings,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: StandingsScreen(competitionId: state.extra as int?),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.fixtureDetails,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: BlocProvider(
              create: (context) => sl<FixtureCubit>(),
              child: FixtureScreen(soccerFixture: state.extra as SoccerFixture),
            ),
          );
        },
      ),
    ],
  );
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(AppStrings.noRouteFound)));
  }
}
