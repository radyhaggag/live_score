import 'package:live_score/src/core/models/country_model.dart';
import 'package:live_score/src/core/utils/app_constants.dart';

import '../domain/entities/league.dart';

class LeagueModel extends League {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.logo,
    super.country,
    super.color,
  });

  factory LeagueModel.fromJson(
    Map<String, dynamic> json, {
    CountryModel? country,
  }) {
    final id = json['id'];
    return LeagueModel(
      id: id,
      name: json['name'],
      logo: AppConstants.competitionImage(id),
      country: country,
      color: json['color'],
    );
  }
}
