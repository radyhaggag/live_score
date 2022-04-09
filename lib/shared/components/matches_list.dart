import 'package:flutter/material.dart';

import '../../models/fixtures_model.dart';
import 'match_card.dart';

ListView buildMatchesList(List<SoccerMatch> leagueMatches) {
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) =>
        buildMatchCard(leagueMatches[index], context),
    separatorBuilder: (context, index) => const SizedBox(height: 5),
    itemCount: leagueMatches.length,
  );
}
