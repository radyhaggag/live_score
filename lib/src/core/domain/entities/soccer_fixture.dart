import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/league.dart';

import 'teams.dart';

class SoccerFixture extends Equatable {
  final int id;
  final Teams teams;
  final String statusText;
  final League fixtureLeague;
  final DateTime? startTime;
  final int? gameTime;
  final int? roundNum;
  final int? stageNum;
  final int? seasonNum;

  const SoccerFixture({
    required this.id,
    required this.teams,
    required this.statusText,
    required this.fixtureLeague,
    this.startTime,
    this.gameTime,
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
    return switch (statusText.toLowerCase()) {
      'not started' ||
      'scheduled' ||
      'canceled' ||
      'postponed' => SoccerFixtureStatus.scheduled,
      'live' ||
      '1st half' ||
      '2nd half' ||
      'halftime' ||
      'extra time' ||
      'penalties' => SoccerFixtureStatus.live,
      'finished' ||
      'fulltime' ||
      'ft' ||
      'aet' ||
      'pen.' ||
      'ended' => SoccerFixtureStatus.ended,
      _ => SoccerFixtureStatus.scheduled,
    };
  }
}

enum SoccerFixtureStatus { scheduled, live, ended }
