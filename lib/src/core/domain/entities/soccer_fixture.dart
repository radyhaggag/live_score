import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/league.dart';

import '../../../features/fixture/domain/enums.dart';
import 'teams.dart';

/// Represents the soccer fixture entity/model.
class SoccerFixture extends Equatable {
  final int id;
  final Teams teams;
  final String statusText;
  final int gameTimeAndStatusDisplayType;
  final League fixtureLeague;
  final DateTime? startTime;
  final int? gameTime;
  final int? addedTime;
  final String gameTimeDisplay;
  final int? roundNum;
  final int? stageNum;
  final int? seasonNum;

  const SoccerFixture({
    required this.id,
    required this.teams,
    required this.statusText,
    required this.gameTimeAndStatusDisplayType,
    required this.fixtureLeague,
    this.startTime,
    this.gameTime,
    this.addedTime,
    this.gameTimeDisplay = '',
    this.roundNum,
    this.stageNum,
    this.seasonNum,
  });

  @override
  List<Object?> get props => [
    id,
    fixtureLeague,
    teams,
    statusText,
    startTime,
    gameTime,
    roundNum,
    stageNum,
    seasonNum,
  ];

  SoccerFixtureStatus get status => switch (gameTimeAndStatusDisplayType) {
    0 => SoccerFixtureStatus.scheduled,
    1 when gameTime != null && gameTime! < 90 => SoccerFixtureStatus.live,
    1 => SoccerFixtureStatus.ended,
    2 => SoccerFixtureStatus.live,
    _ => SoccerFixtureStatus.scheduled,
  };
}
