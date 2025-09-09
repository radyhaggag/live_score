import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/features/soccer/presentation/widgets/block_dialog.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/center_indicator.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';

class SoccerScreen extends StatelessWidget {
  const SoccerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoccerCubit, SoccerStates>(
      listener: (context, state) {
        if (state is SoccerLeaguesLoaded) {
          // context.read<SoccerCubit>().getFixtures();
          // context.read<SoccerCubit>().getLiveFixtures();
        }
        if (state is SoccerFixturesLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
        }
        if (state is SoccerLiveFixturesLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
        }
        if (state is SoccerLeaguesLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        SoccerCubit cubit = context.read<SoccerCubit>();
        return state is SoccerFixturesLoading || state is SoccerLeaguesLoading
            ? centerIndicator()
            : RefreshIndicator(
              onRefresh: () async {
                await cubit.getLiveFixtures();
                // await cubit.getFixtures(); // todo: fetch today fixtures
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cubit.availableLeagues.isNotEmpty) ...[
                        CircleLeaguesHeader(leagues: cubit.availableLeagues),
                        SizedBox(height: 10.height),
                      ],
                      // if (cubit.currentFixtures.isNotEmpty) ...[
                      //   ViewLiveFixtures(fixtures: cubit.currentFixtures),
                      //   SizedBox(height: 10.height),
                      // ],
                      // ViewDayFixtures(fixtures: cubit.dayFixtures),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}

Gradient getGradientColor(SoccerFixture fixture) {
  Gradient color = AppColors.blueGradient;
  if (fixture.teams.away.score != fixture.teams.home.score) {
    color = AppColors.redGradient;
  }
  return color;
}
