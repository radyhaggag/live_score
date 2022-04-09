import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';
import 'package:live_score/models/fixtures_model.dart';
import 'package:live_score/models/lineups_model.dart';

import '../../models/statistics_model.dart';

class StatisticsLayout extends StatelessWidget {
  final SoccerMatch? soccerMatch;
  final String? clockString;
  const StatisticsLayout(
      {Key? key, @required this.soccerMatch, @required this.clockString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveScoreCubit, LiveScoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LiveScoreCubit cubit = LiveScoreCubit.get(context);
        int hourNow =
            int.parse(DateFormat("h").format(DateTime.now().toLocal()));

        int matchHour = int.parse(clockString!.split(":").first);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
                cubit.statsIndex = 0;
                cubit.lineups = [];
                cubit.events = [];
              },
            ),
            title: Text(
              "${soccerMatch!.home!.name} Vs ${soccerMatch!.away!.name}",
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromARGB(255, 19, 62, 153),
                        Color(0xFF4373D9)
                      ]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                          image: NetworkImage(
                            soccerMatch!.league!.logo!,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${soccerMatch!.league!.name}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Round ${soccerMatch!.league!.round!.split(" ").last}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 35,
                                child: Image(
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(
                                    soccerMatch!.home!.logo!,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  soccerMatch!.home!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        (soccerMatch!.fixture!.status!.elapsed != null)
                            ? Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          soccerMatch!.goals!.home!.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          ":",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          soccerMatch!.goals!.away!.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    if (soccerMatch!.fixture!.status!.elapsed !=
                                        null)
                                      const SizedBox(height: 10),
                                    if (soccerMatch!.fixture!.status!.elapsed !=
                                        null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          soccerMatch!.fixture!.status!
                                                      .elapsed! <
                                                  90
                                              ? "Live"
                                              : "End",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      clockString!.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "Not Started",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 35,
                                child: Image(
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(
                                    soccerMatch!.away!.logo!,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  soccerMatch!.away!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        if (soccerMatch!.fixture!.status!.elapsed != null) {
                          cubit
                              .getStatistics(
                            fixtureId: soccerMatch!.fixture!.id.toString(),
                          )
                              .then(
                            (_) {
                              cubit.changStats(0);
                            },
                          );
                        } else {
                          cubit.changStats(0);
                        }
                      },
                      color: Colors.blueGrey,
                      elevation: 0.0,
                      padding: const EdgeInsets.all(16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Text(
                        "Statistics",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        if (hourNow >= matchHour - 1 && cubit.lineups.isEmpty) {
                          cubit
                              .getLineups(
                            fixtureId: soccerMatch!.fixture!.id.toString(),
                          )
                              .then((value) {
                            cubit.changStats(1);
                          });
                        } else {
                          cubit.changStats(1);
                        }
                      },
                      padding: const EdgeInsets.all(16),
                      color: Colors.blueGrey,
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: const Text(
                        "Lineups",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        if (soccerMatch!.fixture!.status!.elapsed != null &&
                            cubit.events.isEmpty) {
                          cubit
                              .getEvents(
                            fixtureId: soccerMatch!.fixture!.id.toString(),
                          )
                              .then(
                            (_) {
                              cubit.changStats(2);
                            },
                          );
                        } else {
                          cubit.changStats(2);
                        }
                      },
                      color: Colors.blueGrey,
                      elevation: 0.0,
                      padding: const EdgeInsets.all(16),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: const Text(
                        "Events",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              if (cubit.statsIndex == 0 && cubit.statistics.isNotEmpty)
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        buildStatsRow(cubit.statistics, index),
                    itemCount: cubit.statistics[0].statistics.length,
                  ),
                ),
              if (cubit.statsIndex == 1 && cubit.lineups.isNotEmpty)
                Column(
                  children: [
                    Container(
                      color: Colors.green,
                      padding: const EdgeInsetsDirectional.all(5),
                      child: Row(
                        children: [
                          Image(
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                            image: NetworkImage(
                              cubit.lineups[0].team!.logo!,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cubit.lineups[0].team!.name!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          const Spacer(),
                          Text(
                            cubit.lineups[0].formation!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 625,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/Football_playground.png",
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        child: Column(
                          children: [
                            buildLineup(cubit.lineups),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      padding: const EdgeInsetsDirectional.all(5),
                      child: Row(
                        children: [
                          Image(
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                            image: NetworkImage(
                              cubit.lineups[1].team!.logo!,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cubit.lineups[1].team!.name!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          const Spacer(),
                          Text(
                            cubit.lineups[1].formation!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              if (cubit.statsIndex == 2 && cubit.events.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  width: 20,
                                  height: 20,
                                  image: NetworkImage(
                                    cubit.events[index].team!.logo.toString(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  cubit.events[index].team!.name.toString(),
                                  style:
                                      const TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: const Color(0xFF4373D9),
                                  child: Text(cubit.events[index].time!.elapsed
                                      .toString()),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cubit.events[index].type.toString(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            cubit.events[index].detail
                                                .toString(),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      if (cubit.events[index].type == "Goal")
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.events[index].player!.name
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            cubit.events[index].detail !=
                                                    "Missed Penalty"
                                                ? const Icon(
                                                    Icons.sports_soccer,
                                                    size: 30,
                                                  )
                                                : Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomEnd,
                                                    children: const [
                                                      Icon(
                                                        Icons.sports_soccer,
                                                        size: 30,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            Colors.red,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            Expanded(
                                              child: Text(
                                                cubit.events[index].assist!
                                                            .name !=
                                                        null
                                                    ? "Assist: " +
                                                        cubit.events[index]
                                                            .assist!.name
                                                            .split(" ")
                                                            .last
                                                    : "No assist",
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (cubit.events[index].type == "Card")
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.events[index].player!.name
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  cubit.events[index].detail ==
                                                          "Yellow Card"
                                                      ? Colors.yellow
                                                      : Colors.red,
                                              width: 20,
                                              height: 30,
                                            ),
                                            const Expanded(
                                              child: Text(
                                                "",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (cubit.events[index].type == "subst")
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.events[index].assist!.name
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            const Image(
                                              width: 40,
                                              height: 40,
                                              image: AssetImage(
                                                "assets/images/substitute.jpg",
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                cubit.events[index].player!.name
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: cubit.events.length,
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Widget buildLineup(List<LineupsModel> lineupsModel) {
    List<String> teamOnePlan = lineupsModel[0].formation!.split("-");
    Iterable<String> teamTwoPlan =
        lineupsModel[1].formation!.split("-").reversed;
    List<Player> teamOnePlayers = lineupsModel[0].startXI;
    Iterable<Player> teamTwoPlayers = lineupsModel[1].startXI.reversed;

    int lineOneNumber = 0;
    int lineTwoNumber = -1;

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: HexColor(
                            "#${lineupsModel[0].team!.playerColors!.primary!}"),
                        child: Text(
                          teamOnePlayers[0].number!.toString(),
                          style: TextStyle(
                              color: HexColor(
                                  "#${lineupsModel[0].team!.playerColors!.number!}")),
                        ),
                      ),
                    ),
                    Text(
                      teamOnePlayers[0].name!,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        int.parse(teamOnePlan[index]),
                        (_) {
                          lineOneNumber++;
                          List<String> playerName =
                              teamOnePlayers[lineOneNumber].name!.split(" ");
                          return Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                  child: CircleAvatar(
                                    radius: 13,
                                    backgroundColor: HexColor(
                                        "#${lineupsModel[0].team!.playerColors!.primary!}"),
                                    child: Text(
                                      teamOnePlayers[lineOneNumber]
                                          .number!
                                          .toString(),
                                      style: TextStyle(
                                        color: HexColor(
                                            "#${lineupsModel[0].team!.playerColors!.number!}"),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  playerName.length >= 3
                                      ? playerName[1] + playerName[2]
                                      : playerName.length == 2
                                          ? playerName[1]
                                          : playerName[0],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  itemCount: teamOnePlan.length,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 80),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        int.parse(teamTwoPlan.elementAt(index)),
                        (_) {
                          lineTwoNumber++;
                          List<String> playerName = teamTwoPlayers
                              .elementAt(lineTwoNumber)
                              .name!
                              .split(" ");
                          return Expanded(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 13,
                                    backgroundColor: HexColor(
                                        "#${lineupsModel[1].team!.playerColors!.primary!}"),
                                    child: Text(
                                      teamTwoPlayers
                                          .elementAt(lineTwoNumber)
                                          .number!
                                          .toString(),
                                      style: TextStyle(
                                          color: HexColor(
                                              "#${lineupsModel[1].team!.playerColors!.number!}")),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  playerName.length >= 3
                                      ? playerName[1] + playerName[2]
                                      : playerName.length == 2
                                          ? playerName[1]
                                          : playerName[0],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  itemCount: teamTwoPlan.length,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: HexColor(
                            "#${lineupsModel[1].team!.playerColors!.primary!}"),
                        child: Text(
                          teamTwoPlayers.elementAt(10).number!.toString(),
                          style: TextStyle(
                              color: HexColor(
                                  "#${lineupsModel[1].team!.playerColors!.number!}")),
                        ),
                      ),
                    ),
                    Text(
                      teamTwoPlayers.elementAt(10).name!,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatsRow(List<StatisticsModel> statistics, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                statistics[0].statistics[index].value.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: Text(
              statistics[0].statistics[index].type!,
              textAlign: TextAlign.center,
            )),
            Expanded(
              child: Text(
                statistics[1].statistics[index].value.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
