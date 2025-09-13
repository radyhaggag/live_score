import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/country.dart';

import '../../utils/app_constants.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String logo;
  final Country? country;
  final String? color;

  const League({
    required this.id,
    required this.name,
    required this.logo,
    this.country,
    this.color,
  });

  /// Factory for a lightweight league (fixture use case)
  factory League.light({required int id, required String name}) {
    return League(
      id: id,
      name: name,
      logo: AppConstants.competitionImage(id), // derived logo
    );
  }

  @override
  List<Object?> get props => [id, name, logo, country, color];
}
