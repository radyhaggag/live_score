import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';

import '../../models/fixtures_model.dart';
import '../../shared/components/league_card.dart';
import '../../shared/components/matches_list.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveScoreCubit, LiveScoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LiveScoreCubit cubit = LiveScoreCubit.get(context);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.leagues.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      cubit.getLeagueId(cubit.leagues[index].id!);
                    },
                    child: buildLeagueCard(cubit, index),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (cubit.leagueId == 0) buildLeagueMatches(cubit.matches),
              if (cubit.leagueId == 39)
                buildLeagueMatches(cubit.premierLeagueMatches),
              if (cubit.leagueId == 140)
                buildLeagueMatches(cubit.laLigaMatches),
              if (cubit.leagueId == 135)
                buildLeagueMatches(cubit.serieAMatches),
              if (cubit.leagueId == 61) buildLeagueMatches(cubit.ligue1Matches),
              if (cubit.leagueId == 78)
                buildLeagueMatches(cubit.bundesligaMatches),
              if (cubit.leagueId == 2)
                buildLeagueMatches(cubit.uefaChampionsMatches),
              if (cubit.leagueId == 12)
                buildLeagueMatches(cubit.cafChampionshipMatches),
              if (cubit.leagueId == 1)
                buildLeagueMatches(cubit.worldCupMatches),
              if (cubit.leagueId == 233)
                buildLeagueMatches(cubit.egyptionLeagueMatches),
            ],
          ),
        );
      },
    );
  }

  Widget buildLeagueMatches(List<SoccerMatch> leagueMatches) {
    return Expanded(
      child: leagueMatches.isNotEmpty
          ? buildMatchesList(leagueMatches)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage(
                    "assets/images/no_matches.webp",
                  ),
                ),
                Text(
                  "No matches scheduled in this competition",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
