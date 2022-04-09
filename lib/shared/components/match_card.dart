import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/statistics_layout/statistics_layout.dart';

import '../../models/fixtures_model.dart';

Widget buildMatchCard(SoccerMatch soccerMatch, context) {
  String dateTimeString = soccerMatch.fixture!.date!;
  final dateTime = DateTime.parse(dateTimeString).toLocal();
  final format = DateFormat("h:mm a");
  final clockString = format.format(dateTime);

  return InkWell(
    onTap: () {
      if (soccerMatch.fixture!.status!.elapsed != null) {
        LiveScoreCubit.get(context)
            .getStatistics(fixtureId: soccerMatch.fixture!.id.toString())
            .then(
          (_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatisticsLayout(
                  soccerMatch: soccerMatch,
                  clockString: clockString,
                ),
              ),
            );
          },
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatisticsLayout(
              soccerMatch: soccerMatch,
              clockString: clockString,
            ),
          ),
        );
      }
    },
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Image(
                    fit: BoxFit.cover,
                    height: 45,
                    width: 45,
                    image: NetworkImage(soccerMatch.home!.logo!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    soccerMatch.home!.name!.split(" ").length >= 2
                        ? soccerMatch.home!.name!.split(" ").first[0] +
                            ". " +
                            soccerMatch.home!.name!.split(" ")[1]
                        : soccerMatch.home!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            (soccerMatch.fixture!.status!.elapsed == null)
                ? Expanded(
                    child: Column(
                      children: [
                        Text(
                          clockString,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${soccerMatch.league!.name}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              soccerMatch.goals!.home!.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              ":",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              soccerMatch.goals!.away!.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${soccerMatch.league!.name}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        if (soccerMatch.fixture!.status!.elapsed != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: soccerMatch.fixture!.status!.elapsed! < 90
                                  ? Colors.red
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              soccerMatch.fixture!.status!.elapsed! < 90
                                  ? "Live"
                                  : "End",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
            Expanded(
              child: Column(
                children: [
                  Image(
                    fit: BoxFit.cover,
                    height: 45,
                    width: 45,
                    image: NetworkImage(soccerMatch.away!.logo!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    soccerMatch.away!.name!.split(" ").length >= 2
                        ? soccerMatch.away!.name!.split(" ").first[0] +
                            ". " +
                            soccerMatch.away!.name!.split(" ")[1]
                        : soccerMatch.away!.name!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
