import 'package:flutter/material.dart';

import '../../models/fixtures_model.dart';
import 'fixtures_card.dart';

ListView buildFixturesList(List<SoccerFixtures> leagueFixtures) {
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) =>
        buildFixtureCard(leagueFixtures[index], context),
    separatorBuilder: (context, index) => const SizedBox(height: 5),
    itemCount: leagueFixtures.length,
  );
}
