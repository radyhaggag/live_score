import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';

import '../../models/fixtures_model.dart';
import '../../shared/components/league_card.dart';
import '../../shared/components/fixtures_list.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({Key? key}) : super(key: key);

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
              if (cubit.leagueId == 0) buildLeagueFixtures(cubit.fixtures),
              if (cubit.leagueId == 39)
                buildLeagueFixtures(cubit.premierLeagueFixtures),
              if (cubit.leagueId == 140)
                buildLeagueFixtures(cubit.laLigaFixtures),
              if (cubit.leagueId == 135)
                buildLeagueFixtures(cubit.serieAFixtures),
              if (cubit.leagueId == 61)
                buildLeagueFixtures(cubit.ligue1Fixtures),
              if (cubit.leagueId == 78)
                buildLeagueFixtures(cubit.bundesligaFixtures),
              if (cubit.leagueId == 2)
                buildLeagueFixtures(cubit.uefaChampionsFixtures),
              if (cubit.leagueId == 12)
                buildLeagueFixtures(cubit.cafChampionshipFixtures),
              if (cubit.leagueId == 1)
                buildLeagueFixtures(cubit.worldCupFixtures),
              if (cubit.leagueId == 233)
                buildLeagueFixtures(cubit.egyptionLeagueFixtures),
            ],
          ),
        );
      },
    );
  }

  Widget buildLeagueFixtures(List<SoccerFixtures> leagueFixtures) {
    return Expanded(
      child: leagueFixtures.isNotEmpty
          ? buildFixturesList(leagueFixtures)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage(
                    "assets/images/no_matches.webp",
                  ),
                ),
                Text(
                  "No Fixtures scheduled in this competition",
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
