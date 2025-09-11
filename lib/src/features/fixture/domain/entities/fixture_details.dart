import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/soccer_fixture.dart';
import 'package:live_score/src/features/fixture/domain/entities/event.dart';
import 'package:live_score/src/features/fixture/domain/entities/lineups.dart';

import 'player.dart';

class FixtureDetails extends Equatable {
  final SoccerFixture fixture;
  final List<Event> events;
  final List<Player> members;
  final Venue venue;

  const FixtureDetails({
    required this.fixture,
    required this.events,
    required this.members,
    required this.venue,
  });

  // match each player with his lineup info
  List<FixturePlayerInfo> get homePlayersInfo {
    final homeLineup = fixture.teams.home.lineup;
    if (homeLineup == null) return [];
    return members.where((player) => player.competitorId == fixture.teams.home.id).map((
      player,
    ) {
      final lineupMember = homeLineup.members.firstWhere(
        (member) => member.id == player.id,
      );
      return FixturePlayerInfo(player: player, lineupMember: lineupMember);
    }).toList();
  }

  List<FixturePlayerInfo> get awayPlayersInfo {
    final awayLineup = fixture.teams.away.lineup;
    if (awayLineup == null) return [];
    return members.where((player) => player.competitorId == fixture.teams.away.id).map((
      player,
    ) {
      final lineupMember = awayLineup.members.firstWhere(
        (member) => member.id == player.id,
      );
      return FixturePlayerInfo(player: player, lineupMember: lineupMember);
    }).toList();
  }

  List<Event> get sortedEvents {
    final sortedEvents = List<Event>.from(events);
    sortedEvents.sort((a, b) => a.order.compareTo(b.order));
    return sortedEvents;
  }

  @override
  List<Object?> get props => [fixture, events, members, venue];
}

class FixturePlayerInfo extends Equatable {
  final Player player;
  final LineupMember lineupMember;

  const FixturePlayerInfo({required this.player, required this.lineupMember});

  @override
  List<Object?> get props => [player, lineupMember];
}

class Venue extends Equatable {
  final int id;
  final String name;
  final String shortName;
  final String? googlePlaceId;

  const Venue({
    required this.id,
    required this.name,
    required this.shortName,
    this.googlePlaceId,
  });

  @override
  List<Object?> get props => [id, name, shortName, googlePlaceId];
}
