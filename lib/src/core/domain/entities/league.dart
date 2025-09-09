import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/country.dart';

class League extends Equatable {
  final int id;
  final int countryId;
  final String name;
  final String logo;
  final Country country;
  final String? color;

  const League({
    required this.id,
    required this.name,
    required this.logo,
    required this.countryId,
    required this.country,
    this.color,
  });

  @override
  List<Object?> get props => [id, name, logo, countryId, country];
}
