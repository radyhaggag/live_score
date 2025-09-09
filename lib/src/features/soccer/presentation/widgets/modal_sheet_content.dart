import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../cubit/soccer_cubit.dart';

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

  const ModalSheetContent({
    super.key,
    required this.league,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: context.height / 5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  width: 20.radius,
                  height: 20.radius,
                  imageUrl: league.logo,
                ),
                SizedBox(width: 10.width),
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
                context.pop();
                context.push(Routes.fixtures, extra: league.id);
              },
              child: const Text(AppStrings.viewFixtures),
            ),
            ElevatedButton(
              onPressed: () async {
                StandingsParams params = StandingsParams(leagueId: league.id);
                context.push(Routes.standings);
                context.pop();
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
