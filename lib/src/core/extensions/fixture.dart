import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/soccer_fixture.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

extension FixtureExtension on SoccerFixture {
  Gradient gradientColor(BuildContext context) {
    return isThereWinner
        ? context.colorsExt.redGradient
        : context.colorsExt.blueGradient;
  }

  bool get isThereWinner {
    return teams.away.score != teams.home.score;
  }
}
