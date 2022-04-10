import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/statistics_layout/statistics_layout.dart';
import '../../models/fixtures_model.dart';

Widget buildLiveFixtureCard(SoccerFixtures soccerFixture, context) {
  String dateTimeString = soccerFixture.fixture!.date!;
  final dateTime = DateTime.parse(dateTimeString).toLocal();
  final format = DateFormat("h:mm a");
  final clockString = format.format(dateTime);

  return InkWell(
    onTap: () {
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
    },
    child: Card(
      color: const Color(0xFFFAFAFA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.all(20),
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: (soccerFixture.league!.id == 39 ||
                    soccerFixture.league!.id == 2 ||
                    soccerFixture.league!.id == 2 ||
                    soccerFixture.league!.id == 135)
                ? <Color>[
                    const Color.fromARGB(255, 19, 62, 153),
                    const Color(0xFF4373D9)
                  ]
                : <Color>[
                    const Color.fromARGB(255, 241, 73, 73),
                    const Color.fromARGB(255, 202, 8, 37),
                  ],
          ),
        ),
        child: Column(
          children: [
            Text(
              soccerFixture.league!.name!,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Image(
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                    image: NetworkImage(soccerFixture.home!.logo!),
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Image(
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                    image: NetworkImage(soccerFixture.away!.logo!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  soccerFixture.home!.name!.split(" ").length >= 2
                      ? soccerFixture.home!.name!.split(" ").first[0] +
                          ". " +
                          soccerFixture.home!.name!.split(" ")[1]
                      : soccerFixture.home!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  soccerFixture.goals!.home.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  soccerFixture.away!.name!.split(" ").length >= 2
                      ? soccerFixture.away!.name!.split(" ").first[0] +
                          ". " +
                          soccerFixture.away!.name!.split(" ")[1]
                      : soccerFixture.away!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  soccerFixture.goals!.away.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Live",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
