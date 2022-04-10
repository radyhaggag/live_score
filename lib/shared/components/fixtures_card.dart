import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/statistics_layout/statistics_layout.dart';

import '../../models/fixtures_model.dart';

Widget buildFixtureCard(SoccerFixtures soccerFixture, context) {
  String dateTimeString = soccerFixture.fixture!.date!;
  final dateTime = DateTime.parse(dateTimeString).toLocal();
  final format = DateFormat("h:mm a");
  final clockString = format.format(dateTime);

  return InkWell(
    onTap: () {
      if (soccerFixture.fixture!.status!.elapsed != null) {
        LiveScoreCubit.get(context)
            .getStatistics(fixtureId: soccerFixture.fixture!.id.toString())
            .then(
          (_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatisticsLayout(
                  soccerFixture: soccerFixture,
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
              soccerFixture: soccerFixture,
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
                    image: NetworkImage(soccerFixture.home!.logo!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    soccerFixture.home!.name!.split(" ").length >= 2
                        ? soccerFixture.home!.name!.split(" ").first[0] +
                            ". " +
                            soccerFixture.home!.name!.split(" ")[1]
                        : soccerFixture.home!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            (soccerFixture.fixture!.status!.elapsed == null)
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
                          "${soccerFixture.league!.name}",
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
                              soccerFixture.goals!.home!.toString(),
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
                              soccerFixture.goals!.away!.toString(),
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
                          "${soccerFixture.league!.name}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        if (soccerFixture.fixture!.status!.elapsed != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  soccerFixture.fixture!.status!.elapsed! < 90
                                      ? Colors.red
                                      : Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              soccerFixture.fixture!.status!.elapsed! < 90
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
                    image: NetworkImage(soccerFixture.away!.logo!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    soccerFixture.away!.name!.split(" ").length >= 2
                        ? soccerFixture.away!.name!.split(" ").first[0] +
                            ". " +
                            soccerFixture.away!.name!.split(" ")[1]
                        : soccerFixture.away!.name!,
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
