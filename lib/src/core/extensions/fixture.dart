import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/soccer_fixture.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

extension FixtureExtension on SoccerFixture {
  Gradient get gradientColor {
    Gradient color = AppColors.blueGradient;
    if (teams.away.score != teams.home.score) color = AppColors.redGradient;

    return color;
  }
}
