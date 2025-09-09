import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/utils/app_constants.dart';

import 'teams.dart';

class SoccerFixture extends Equatable {
  final int id;
  final Teams teams;
  final String statusText;
  final int gameTimeAndStatusDisplayType;
  final FixtureLeague fixtureLeague;
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

  SoccerFixtureStatus get status {
    return switch (gameTimeAndStatusDisplayType) {
      1 => SoccerFixtureStatus.ended,
      0 => SoccerFixtureStatus.scheduled,
      2 => SoccerFixtureStatus.live,
      _ => SoccerFixtureStatus.scheduled,
    };
  }
}

enum SoccerFixtureStatus {
  scheduled,
  live,
  ended;

  bool get isLive => this == SoccerFixtureStatus.live;
  bool get isEnded => this == SoccerFixtureStatus.ended;
  bool get isScheduled => this == SoccerFixtureStatus.scheduled;
}

class FixtureLeague extends Equatable {
  final int id;
  final String name;

  const FixtureLeague({required this.id, required this.name});

  String get logo => AppConstants.competitionImage(id);

  @override
  List<Object?> get props => [id, name];
}
