import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/soccer_fixture.dart';
import 'package:live_score/src/features/fixture/domain/entities/event.dart';
import 'package:live_score/src/features/fixture/domain/entities/lineups.dart';

import 'player.dart';

/// Represents the fixture details entity/model.
class FixtureDetails extends Equatable {
  final SoccerFixture fixture;
  final List<Event> events;
  final List<Player> members;
  final Venue? venue;

  const FixtureDetails({
    required this.fixture,
    required this.events,
    required this.members,
    this.venue,
  });

  // match each player with his lineup info
  List<FixturePlayerInfo> get homePlayersInfo {
    final homeLineup = fixture.teams.home.lineup;
    if (homeLineup == null) return [];
    
    final result = <FixturePlayerInfo>[];
    for (final player in members) {
      if (player.competitorId == fixture.teams.home.id) {
        final lineupMembers = homeLineup.members.where((m) => m.id == player.id);
        if (lineupMembers.isNotEmpty) {
          result.add(FixturePlayerInfo(player: player, lineupMember: lineupMembers.first));
        }
      }
    }
    return result;
  }

  List<FixturePlayerInfo> get awayPlayersInfo {
    final awayLineup = fixture.teams.away.lineup;
    if (awayLineup == null) return [];
    
    final result = <FixturePlayerInfo>[];
    for (final player in members) {
      if (player.competitorId == fixture.teams.away.id) {
        final lineupMembers = awayLineup.members.where((m) => m.id == player.id);
        if (lineupMembers.isNotEmpty) {
          result.add(FixturePlayerInfo(player: player, lineupMember: lineupMembers.first));
        }
      }
    }
    return result;
  }

  List<Event> get sortedEvents {
    final sortedEvents = List<Event>.from(events);
    sortedEvents.sort((a, b) => a.order.compareTo(b.order));
    return sortedEvents;
  }

  @override
  List<Object?> get props => [fixture, events, members, venue];
}

/// Represents the fixture player info entity/model.
class FixturePlayerInfo extends Equatable {
  final Player player;
  final LineupMember lineupMember;

  const FixturePlayerInfo({required this.player, required this.lineupMember});

  @override
  List<Object?> get props => [player, lineupMember];
}

/// Represents the venue entity/model.
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
