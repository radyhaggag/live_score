import 'package:equatable/equatable.dart';
import 'fixture.dart';

import 'fixture_league.dart';
import 'goals.dart';
import 'teams.dart';

class SoccerFixture extends Equatable {
  final Fixture fixture;
  final FixtureLeague fixtureLeague;
  final Teams teams;
  final Goals goals;

  const SoccerFixture({
    required this.fixture,
    required this.fixtureLeague,
    required this.teams,
    required this.goals,
  });

  @override
  List<Object?> get props => [fixture, fixtureLeague, teams, goals];
}
