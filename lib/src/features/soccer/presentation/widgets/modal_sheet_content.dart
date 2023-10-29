import 'package:flutter/material.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../cubit/soccer_cubit.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/domain/entities/league.dart';

Future<dynamic> buildBottomSheet({
  required BuildContext context,
  required League league,
  required SoccerCubit cubit,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    context: context,
    builder: (context) => ModalSheetContent(league: league, cubit: cubit),
  );
}

class ModalSheetContent extends StatelessWidget {
  final League league;
  final SoccerCubit cubit;

  const ModalSheetContent(
      {super.key, required this.league, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p15),
      height: context.height / 5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  image: NetworkImage(league.logo),
                ),
                const SizedBox(width: AppSize.s10),
                Flexible(
                  child: Text(
                    league.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cubit.currentFixtures =
                    AppConstants.leaguesFixtures[league.id]?.fixtures ?? [];
                Navigator.pop(context);
                cubit.changeBottomNav(1);
              },
              child: const Text(AppStrings.viewFixtures),
            ),
            ElevatedButton(
              onPressed: () async {
                StandingsParams params = StandingsParams(
                    leagueId: league.id.toString(),
                    season: league.year.toString());
                cubit.changeBottomNav(2);
                Navigator.pop(context);
                await cubit.getStandings(params);
              },
              child: const Text("View Standings"),
            ),
          ],
        ),
      ),
    );
  }
}
