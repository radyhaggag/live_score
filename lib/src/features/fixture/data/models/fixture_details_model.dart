import 'package:live_score/src/core/domain/entities/league.dart';
import 'package:live_score/src/features/fixture/data/models/event_model.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/models/soccer_fixture_model.dart';
import 'player_model.dart';

class FixtureDetailsModel extends FixtureDetails {
  const FixtureDetailsModel({
    required super.fixture,
    required super.events,
    required super.members,
    required super.venue,
  });

  factory FixtureDetailsModel.fromJson(Map<String, dynamic> json) {
    final competitionId = json['competitionId'];
    final competitionName = json['competitionDisplayName'] ?? '';
    return FixtureDetailsModel(
      fixture: SoccerFixtureModel.fromJson(
        json,
        fixtureLeague: League.light(id: competitionId, name: competitionName),
      ),
      events:
          json['events'] != null
              ? (json['events'] as List)
                  .map((e) => EventModel.fromJson(e))
                  .toList()
              : [],
      members:
          json['members'] != null
              ? (json['members'] as List)
                  .map((e) => PlayerModel.fromJson(e))
                  .toList()
              : [],
      venue: VenueModel.fromJson(json['venue']),
    );
  }
}

class VenueModel extends Venue {
  const VenueModel({
    required super.id,
    required super.name,
    required super.shortName,
    super.googlePlaceId,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      googlePlaceId: json['googlePlaceId'],
    );
  }
}
