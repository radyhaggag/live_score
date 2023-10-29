import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/center_indicator.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/view_fixtures.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';
import '../widgets/block_dialog.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../widgets/leagues_header.dart';

class SoccerScreen extends StatefulWidget {
  const SoccerScreen({super.key});

  @override
  State<SoccerScreen> createState() => _SoccerScreenState();
}

class _SoccerScreenState extends State<SoccerScreen> {
  List<SoccerFixture> fixtures = [];
  List<SoccerFixture> liveFixtures = [];

  @override
  void initState() {
    super.initState();
    getLists();
  }

  getLists() async {
    SoccerCubit cubit = context.read<SoccerCubit>();
    if (cubit.filteredLeagues.isEmpty) {
      await cubit.getLeagues();
    }
    if (cubit.filteredLeagues.isNotEmpty) {
      await cubit.getLiveFixtures().then((value) {
        cubit.currentFixtures = liveFixtures = value;
      });
    }
    if (cubit.filteredLeagues.isNotEmpty && fixtures.isEmpty) {
      fixtures = await cubit.getFixtures();
    }
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoccerCubit, SoccerStates>(
      listener: (context, state) {
        if (state is SoccerLeaguesLoaded && state.leagues.isEmpty) {
          buildBlockAlert(context: context, message: AppStrings.reachedLimits);
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
                  await cubit.getFixtures();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (cubit.filteredLeagues.isNotEmpty) ...[
                          LeaguesHeader(leagues: cubit.filteredLeagues),
                          const SizedBox(height: AppSize.s10),
                        ],
                        if (liveFixtures.isNotEmpty) ...[
                          ViewLiveFixtures(fixtures: liveFixtures),
                          const SizedBox(height: AppSize.s10),
                        ],
                        ViewDayFixtures(fixtures: fixtures),
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
  if (fixture.goals.away != fixture.goals.home) {
    color = AppColors.redGradient;
  }
  return color;
}
