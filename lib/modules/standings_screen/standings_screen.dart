import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';
import 'package:live_score/models/standings_model.dart';

import '../../shared/components/league_card.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveScoreCubit, LiveScoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LiveScoreCubit cubit = LiveScoreCubit.get(context);

        int indexOfGroups = -1;
        int groupId = 64;

        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
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
                      cubit.getStandings(
                        season: cubit.leagues[index].currentYear.toString(),
                        leagueId: cubit.leagues[index].id.toString(),
                      );
                    },
                    child: buildLeagueCard(cubit, index),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            if (state is LiveScoreGetStandingsLoadingState)
              const Center(child: LinearProgressIndicator()),
            (cubit.standingsGroups.length == 1)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: buildStandingsHeader(),
                        ),
                        ...List.generate(
                          cubit.standings.length,
                          (index) => buildStandingsItem(cubit.standings[index]),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ...List.generate(
                          cubit.standingsGroups.length,
                          (index) {
                            groupId++;
                            return Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      "Group ${String.fromCharCode(groupId)}",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: buildStandingsHeader(),
                                  ),
                                  ...List.generate(
                                    cubit.standingsGroups[index].length,
                                    (index) {
                                      indexOfGroups++;
                                      return buildStandingsItem(
                                          cubit.standings[indexOfGroups]);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
            if (cubit.standings.isEmpty &&
                state is! LiveScoreGetStandingsLoadingState)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Select league to view standings",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildStandingsHeader() {
    List<String> headers = ["GP", "W", "D", "L", "GF", "GA", "+/-", "PTS"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 200,
            child: Text(
              "Team name",
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  headers.length,
                  (index) => SizedBox(
                    width: 30,
                    child: Text(headers[index], textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const SizedBox(
            width: 110,
            child: Text("Form"),
          ),
        ],
      ),
    );
  }

  Widget buildStandingsItem(StandingsModel standingsModel) {
    List<String> form = standingsModel.form!.split("");
    List<String> headersNumbers = [
      "${standingsModel.points}",
      "${standingsModel.all!.win}",
      "${standingsModel.all!.draw}",
      "${standingsModel.all!.lose}",
      "${standingsModel.all!.goalsFor}",
      "${standingsModel.all!.goalsAgainst}",
      "${standingsModel.goalsDiff}",
      "${standingsModel.points}",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    standingsModel.rank.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Image(
                  width: 20,
                  height: 20,
                  image: NetworkImage(
                    standingsModel.team!.logo!,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    standingsModel.team!.name!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  headersNumbers.length,
                  (index) => SizedBox(
                    width: 30,
                    child: Text(
                      headersNumbers[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  form.length,
                  (index) => Container(
                    width: 18,
                    height: 18,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      color: form[index] == "W"
                          ? Colors.green
                          : form[index] == "L"
                              ? Colors.red
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: form[index] == "W"
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : form[index] == "L"
                            ? const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              )
                            : const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
