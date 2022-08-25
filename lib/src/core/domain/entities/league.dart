import 'package:equatable/equatable.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String type;
  final String logo;
  final int year;

  const League({
    required this.id,
    required this.name,
    required this.type,
    required this.logo,
    required this.year,
  });

  @override
  List<Object?> get props => [id, name, type, logo, year];
}
