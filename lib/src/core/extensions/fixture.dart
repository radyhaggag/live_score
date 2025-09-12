import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/soccer_fixture.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

extension FixtureExtension on SoccerFixture {
  Gradient get gradientColor {
    return isThereWinner ? AppColors.redGradient : AppColors.blueGradient;
  }

  bool get isThereWinner {
    return teams.away.score != teams.home.score;
  }
}
